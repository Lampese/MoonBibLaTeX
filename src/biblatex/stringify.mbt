///|
fn Value::stringify(self : Value) -> String {
  match self {
    Value::String(s) => "\"\{s}\""
    Value::Digit(i) => i.to_string()
    Value::Month(m) => m
  }
}

///|
pub fn Entry::stringify(self : Entry) -> String {
  let result = StringBuilder::new()
  result.write_char('@')
  result.write_string(self.entry_type())
  result.write_char('{')
  result.write_string(self.cite_key())
  result.write_char(',')
  result.write_string(
    self.fields.iter().map(x => "\{x.0} = \{x.1.stringify()}").join(", "),
  )
  result.write_char('}')
  result.to_string()
}

///|
pub fn Bibliography::stringify(self : Bibliography) -> String {
  self.entries.iter().map(x => x.1.stringify()).join("\n")
}
