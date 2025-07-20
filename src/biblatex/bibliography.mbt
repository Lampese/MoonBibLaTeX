///|
/// A Bibliography is a collection of entries.
/// Bibliography can be constructed from parsed biblatex file or constructed by `Bibliography::new` method.
/// ```mbt
/// let code=
///   #|@article{CitekeyArticle,
///   #|  author   = "P. J. Cohen",
///   #|  title    = "The independence of the continuum hypothesis",
///   #|  journal  = "Proceedings of the National Academy of Sciences",
///   #|  year     = 1963,
///   #|  volume   = "50",
///   #|  number   = "6",
///   #|  pages    = "1143--1148",
///   #|}
/// let _bib1 = Bibliography::parse(code)
/// let _bib2 = Bibliography::new()
/// ```
pub struct Bibliography {
  priv entries : Map[String, Entry]
}

///|
/// Create a new empty Bibliography.
/// ```mbt
/// let _ = Bibliography::new()
/// ```
pub fn Bibliography::new() -> Bibliography {
  { entries: {} }
}

///|
/// Add or modify an entry to the Bibliography.
/// ```mbt
/// let bib = Bibliography::new()
/// let entry = Entry::new(
///   entry_type="article",
///   cite_key="CitekeyArticle",
///   fields={
///     "author":String("P. J. Cohen"),
///     "title":String("The independence of the continuum hypothesis"),
///     "journal":String("Proceedings of the National Academy of Sciences"),
///     "year":Digit(1963),
///     "volume":String("50"),
///     "number":String("6"),
///     "pages":String("1143--1148"),
///   }
/// )
/// bib.set(entry)
/// ```
pub fn Bibliography::set(self : Bibliography, entry : Entry) -> Unit {
  self.entries.set(entry.cite_key, entry)
}

///|
/// Remove an entry from the Bibliography.
/// ```mbt
/// let bib = Bibliography::new()
/// let entry = Entry::new(
///   entry_type="article",
///   cite_key="CitekeyArticle",
///   fields={
///     "author":String("P. J. Cohen"),
///     "title":String("The independence of the continuum hypothesis"),
///     "journal":String("Proceedings of the National Academy of Sciences"),
///     "year":Digit(1963),
///     "volume":String("50"),
///     "number":String("6"),
///     "pages":String("1143--1148"),
///   }
/// )
/// bib.set(entry)
/// bib.remove("CitekeyArticle")
/// ```
pub fn Bibliography::remove(self : Bibliography, cite_key : String) -> Unit {
  self.entries.remove(cite_key)
}

///|
/// Get the size of the Bibliography.
/// ```mbt
/// let bib = Bibliography::new()
/// bib.size() |> ignore() // 0
/// ```
pub fn Bibliography::size(self : Bibliography) -> Int {
  self.entries.size()
}

///|
/// Get the iterator of the Bibliography.
/// ```mbt
/// let bib = Bibliography::new()
/// println(bib.iter().to_array().length()) // 0 
/// ```
pub fn Bibliography::iter(self : Bibliography) -> Iter[Entry] {
  self.entries.iter().map(x => x.1).iter()
}

///|
/// Get the entry with the given cite key.
/// ```mbt
/// let bib = Bibliography::new()
/// bib.get("CitekeyArticle") |> ignore() // None
/// ```
pub fn Bibliography::get(self : Bibliography, cite_key : String) -> Entry? {
  self.entries.get(cite_key)
}

///|
/// Get the entry map of the Bibliography.
/// Notice that this method is not recommended to use. (Unless you know exactly what you're doing)
/// ```mbt
/// let bib = Bibliography::new()
/// bib.get_entry_map() |> ignore()// {}
/// ```
pub fn Bibliography::get_entry_map(self : Bibliography) -> Map[String, Entry] {
  self.entries
}
