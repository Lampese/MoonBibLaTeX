///|
priv enum Token {
  LBrace
  RBrace
  Entry(String)
  Equal
  String(String)
  Identifier(String)
  Digit(Int)
  Comma
  Nil
}

///|
typealias Array[Token] as Tokens

///|
priv struct Lexer {
  input : String
  mut currentChar : Char?
  mut currentIndex : Int
}

///|
fn Lexer::new(input : String) -> Lexer {
  { input, currentChar: Some(input.get_char(0).unwrap()), currentIndex: 1 }
}

///|
fn Lexer::advance(self : Lexer) -> Unit {
  if self.currentIndex < self.input.length() {
    self.currentChar = Some(self.input.get_char(self.currentIndex).unwrap())
    self.currentIndex += 1
  } else {
    self.currentChar = None
  }
}

///|
fn Lexer::back(self : Lexer) -> Unit {
  self.currentIndex -= 1
  self.currentChar = Some(self.input.get_char(self.currentIndex).unwrap())
}

///|
fn Lexer::read_entry(self : Lexer) -> String {
  loop (self.currentChar, "") {
    (Some(char), str) if char is ('a'..='z') || char is ('A'..='Z') => {
      self.advance()
      continue (self.currentChar, str + char.to_string())
    }
    (_, res) => break res
  }
}

///|
fn Lexer::read_string_quote(self : Lexer) -> String {
  loop (self.currentChar, "") {
    (Some('\\'), str) => {
      self.advance() // drop \
      let char = self.escape_handle('"', true)
      self.advance() // drop current char
      continue (self.currentChar, str + char)
    }
    (Some(char), str) if not(char == '"') => {
      self.advance()
      continue (self.currentChar, str + char.to_string())
    }
    (_, res) => break res
  }
}

///|
fn Lexer::escape_handle(
  self : Lexer,
  start_char : Char,
  first_layer : Bool,
) -> String {
  let end_char = match start_char {
    '{' => '}'
    '"' => '"'
    _ => abort("Lexer: Expected escape character")
  }
  let char = match self.currentChar {
    Some('{') => "{"
    Some('}') => "}"
    Some('"') => "\""
    Some('\\') => "\\"
    Some(_) => {
      let buffer = StringBuilder::new()
      buffer.write_char('\\')
      while not(
              self.currentChar is (None | Some(' ') | Some('{')) ||
              (first_layer && self.currentChar is Some(c) && c == end_char),
            ) {
        if self.currentChar is Some('\\') {
          buffer.write_string(Lexer::escape_handle(self, start_char, false))
          self.advance() // notice that
        } else {
          buffer.write_char(self.currentChar.unwrap())
        }
        self.advance()
      }
      match self.currentChar {
        Some('{') => {
          self.advance()
          buffer.write_char('{')
          buffer.write_string(Lexer::read_string_brace(self))
          buffer.write_char('}')
        }
        Some('}') if start_char == '{' => self.back()
        Some('"') if start_char == '"' => self.back()
        _ => ()
      }
      buffer.to_string()
    }
    None => abort("Lexer: Expected escape character")
  }
  char
}

///|
fn Lexer::read_string_brace(self : Lexer) -> String {
  let mut brace_count = 0
  loop (self.currentChar, "") {
    (Some('\\'), str) => {
      self.advance() // drop \
      let char = self.escape_handle('{', true)
      self.advance() // drop current char
      continue (self.currentChar, str + char)
    }
    (Some('{'), str) => {
      brace_count += 1
      self.advance()
      continue (self.currentChar, str)
    }
    (Some('}'), str) if brace_count > 0 => {
      brace_count -= 1
      self.advance()
      continue (self.currentChar, str)
    }
    (Some(char), str) if not(char == '}') => {
      self.advance()
      continue (self.currentChar, str + char.to_string())
    }
    (_, res) => break res
  }
}

///|
fn Lexer::read_identifier(self : Lexer) -> String {
  loop (self.currentChar, "") {
    (Some(char), str) if not(char is (',' | '=' | '}' | '\n' | '\r' | ' ')) => {
      self.advance()
      continue (self.currentChar, str + char.to_string())
    }
    (_, res) => break res
  }
}

///|
fn Lexer::read_number(self : Lexer) -> Int {
  (try? @strconv.parse_int(
    loop (self.currentChar, "") {
      (Some(char), str) if char is ('0'..='9') => {
        self.advance()
        continue (self.currentChar, str + char.to_string())
      }
      (_, res) => break res
    },
  )).unwrap()
}

///|
fn Lexer::lexing(self : Lexer) -> Tokens {
  let tokens = []
  let mut last_push = Nil
  while self.currentChar is Some(char) {
    match char {
      '@' => {
        self.advance()
        last_push = Entry(self.read_entry())
        tokens.push(last_push)
      }
      '=' => {
        last_push = Equal
        tokens.push(last_push)
        self.advance()
      }
      ',' => {
        last_push = Comma
        tokens.push(last_push)
        self.advance()
      }
      '"' => {
        self.advance()
        last_push = String(self.read_string_quote())
        tokens.push(last_push)
        self.advance()
      }
      '{' =>
        if last_push is Equal {
          self.advance()
          last_push = String(self.read_string_brace())
          tokens.push(last_push)
          self.advance()
        } else {
          last_push = LBrace
          tokens.push(last_push)
          self.advance()
        }
      '}' => {
        self.advance()
        last_push = RBrace
        tokens.push(last_push)
      }
      '0'..='9' => {
        last_push = Digit(self.read_number())
        tokens.push(last_push)
      }
      'a'..='z' | 'A'..='Z' => {
        last_push = Identifier(self.read_identifier())
        tokens.push(last_push)
      }
      _ => self.advance()
    }
  }
  tokens
}
