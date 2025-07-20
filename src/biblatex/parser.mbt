///|
priv enum InnerValue {
  String(String)
  Digit(Int)
  Month(String)
  ToValue(String)
}

///|
priv struct StringDefine {
  string_name : String
  value : InnerValue
}

///|
priv struct Parser {
  tokens : Tokens
  mut currentToken : Token?
  mut currentIndex : Int
}

///|
fn Parser::new(tokens : Tokens) -> Parser {
  { tokens, currentToken: tokens.get(0), currentIndex: 1 }
}

///|
fn Parser::advance(self : Parser) -> Unit {
  if self.currentIndex < self.tokens.length() {
    self.currentToken = self.tokens.get(self.currentIndex)
    self.currentIndex += 1
  } else {
    self.currentToken = None
  }
}

///|
fn Parser::parse(self : Parser) -> Bibliography {
  let (entries, string_defines) = self.parse_entry()
  transfrom(entries, string_defines)
}

///|
fn Parser::parse_entry(
  self : Parser
) -> (Array[InnerEntry], Array[StringDefine]) {
  let entries = []
  let string_defines = []
  while self.currentToken is Some(Entry(entry)) {
    if entry.to_lower() == "string" {
      self.advance() // drop entry name
      self.advance() // skip {
      let string_define = self.parse_string_define()
      self.advance() // drop }
      string_defines.push(string_define)
    } else {
      self.advance() // drop entry name
      self.advance() // skip {
      guard self.currentToken is Some(Identifier(cite_key)) else {
        abort("Parser: Expected cite key")
      }
      self.advance() // drop cite key
      self.advance() // skip ,
      let fields = self.parse_fields()
      self.advance() // drop }
      entries.push(InnerEntry::{ entry, cite_key, fields })
    }
  }
  (entries, string_defines)
}

///|
fn Parser::parse_string_define(self : Parser) -> StringDefine {
  guard self.currentToken is Some(Identifier(string_name)) else {
    abort("Parser: Expected string name")
  }
  self.advance() // drop string name
  guard self.currentToken is Some(Equal) else {
    abort("Parser: Expected equal sign")
  }
  self.advance() // drop =
  let value = self.parse_value()
  self.advance() // drop value
  { string_name, value }
}

///|
fn Parser::parse_fields(self : Parser) -> Map[String, InnerValue] {
  let fields = {}
  while not(self.currentToken is Some(RBrace)) {
    guard self.currentToken is Some(Identifier(field_name)) else {
      abort("Parser: Expected field name")
    }
    self.advance() // drop field name
    guard self.currentToken is Some(Equal) else {
      abort("Parser: Expected equal sign")
    }
    self.advance() // drop =
    let value = self.parse_value()
    self.advance() // drop value
    if self.currentToken is Some(Comma) {
      self.advance() // drop , notice last field has no comma
    }
    fields.set(field_name, value)
  }
  fields
}

///|
fn Parser::parse_value(self : Parser) -> InnerValue {
  match self.currentToken {
    Some(
      Identifier(
        "jan"
        | "feb"
        | "mar"
        | "apr"
        | "may"
        | "jun"
        | "jul"
        | "aug"
        | "sep"
        | "oct"
        | "nov"
        | "dec" as value
      )
    ) => Month(value)
    Some(Identifier(value)) => ToValue(value)
    Some(String(value)) => String(value)
    Some(Digit(value)) => Digit(value)
    _ => abort("Parser: Expected value")
  }
}

///|
pub fn parse(input : String) -> Bibliography {
  let lexer = Lexer::new(input).lexing()
  let parser = Parser::new(lexer)
  parser.parse()
}
