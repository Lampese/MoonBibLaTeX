///|
fn Value::stringify(self : Value) -> String {
  match self {
    Value::String(s) => "\"\{s}\""
    Value::Digit(i) => i.to_string()
    Value::Month(m) => m
  }
}

///|
/// Stringify the Entry into a string.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "volume":Digit(1),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.stringify() |> ignore() // "@article{CitekeyArticle, volume = 1, journal = Proceedings of the National Academy of Sciences}"
/// ```
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
/// Stringify the Bibliography into a string.
/// ```mbt
/// let bib = Bibliography::new()
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "volume":Digit(1),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// bib.set(entry)
/// bib.stringify() |> ignore() // "@article{CitekeyArticle, volume = 1, journal = Proceedings of the National Academy of Sciences}"
/// ```
pub fn Bibliography::stringify(self : Bibliography) -> String {
  self.entries.iter().map(x => x.1.stringify()).join("\n")
}
