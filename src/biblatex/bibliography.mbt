///|
pub struct Bibliography {
  priv entries : Map[String, Entry]
}

///|
pub fn Bibliography::new() -> Bibliography {
  { entries: {} }
}

///|
pub fn Bibliography::set(self : Bibliography, entry : Entry) -> Unit {
  self.entries.set(entry.cite_key, entry)
}

///|
pub fn Bibliography::remove(self : Bibliography, cite_key : String) -> Unit {
  self.entries.remove(cite_key)
}

///|
pub fn Bibliography::size(self : Bibliography) -> Int {
  self.entries.size()
}

///|
pub fn Bibliography::iter(self : Bibliography) -> Iter[Entry] {
  self.entries.iter().map(x => x.1).iter()
}

///|
pub fn Bibliography::get(self : Bibliography, cite_key : String) -> Entry? {
  self.entries.get(cite_key)
}

///|
pub fn Bibliography::get_entry_map(self : Bibliography) -> Map[String, Entry] {
  self.entries
}
