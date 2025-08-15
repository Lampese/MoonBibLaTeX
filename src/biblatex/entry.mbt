/// A Value is a value of a field in an entry.
/// Value can be a string, a digit, or a month.
/// ```mbt
/// let value = Value::String("Hello, world!")
/// let value = Value::Digit(123)
/// let value = Value::Month("jan")
/// ```

///|
pub(all) enum Value {
  String(String)
  Digit(Int)
  Month(String)
} derive(Show)

///|
priv struct InnerEntry {
  entry : String
  cite_key : String
  fields : Map[String, InnerValue]
}

///|
/// An Entry is a single entry in a bibliography.
/// Entry can be constructed by `Entry::new` method or extracted from a Bibliography.
/// Entries defined by https://www.bibtex.com/e/entry-types/
pub struct Entry {
  priv mut entry : String
  priv mut cite_key : String
  priv fields : Map[String, Value]
}

///|
/// Create a new Entry.
/// ```mbt
/// let _ = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "author":String("P. J. Cohen"),
///   "title":String("The independence of the continuum hypothesis"),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// ```
pub fn Entry::new(
  entry_type~ : String,
  cite_key~ : String,
  fields~ : Map[String, Value] = {},
) -> Entry {
  { entry: entry_type, cite_key, fields }
}

///|
/// Get the fields of the Entry.
/// Notice that this method is not recommended to use. (Unless you know exactly what you're doing)
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "author":String("P. J. Cohen"),
///   "title":String("The independence of the continuum hypothesis"),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.fields() |> ignore() // { "author":String("P. J. Cohen"), "title":String("The independence of the continuum hypothesis"), "journal":String("Proceedings of the National Academy of Sciences") }
/// ```
pub fn Entry::fields(self : Entry) -> Map[String, Value] {
  self.fields
}

///|
/// Get the size of the Entry.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "author":String("P. J. Cohen"),
///   "title":String("The independence of the continuum hypothesis"),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.size() |> ignore() // 3
/// ```
pub fn Entry::size(self : Entry) -> Int {
  self.fields.size()
}

///|
/// Get the entry type of the Entry.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "author":String("P. J. Cohen"),
///   "title":String("The independence of the continuum hypothesis"),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.entry_type() |> ignore() // "article"
/// ```
pub fn Entry::entry_type(self : Entry) -> String {
  self.entry
}

///|
/// Set the entry type of the Entry.
/// Notice that this method is not safe (will not check if the entry type is valid).
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "author":String("P. J. Cohen"),
///   "title":String("The independence of the continuum hypothesis"),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.set_entry_type("book")
/// entry.entry_type() |> ignore() // "book"
/// ```
pub fn Entry::set_entry_type(self : Entry, entry_type : String) -> Unit {
  self.entry = entry_type
}

///|
/// Get the cite key of the Entry.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "author":String("P. J. Cohen"),
///   "title":String("The independence of the continuum hypothesis"),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.cite_key() |> ignore() // "CitekeyArticle"
/// ```
pub fn Entry::cite_key(self : Entry) -> String {
  self.cite_key
}

///|
/// Set the cite key of the Entry.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "author":String("P. J. Cohen"),
///   "title":String("The independence of the continuum hypothesis"),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.set_cite_key("CitekeyArticle2")
/// entry.cite_key() |> ignore() // "CitekeyArticle2"
/// ```
pub fn Entry::set_cite_key(self : Entry, cite_key : String) -> Unit {
  self.cite_key = cite_key
}

///|
/// Get the author of the Entry.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "author":String("P. J. Cohen"),
///   "title":String("The independence of the continuum hypothesis"),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.author() |> ignore() // Some("P. J. Cohen")
/// ```
pub fn Entry::author(self : Entry) -> String? {
  match self.fields.get("author") {
    Some(Value::String(author)) => Some(author)
    _ => None
  }
}

///|
/// Set the author of the Entry.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "author":String("P. J. Cohen"),
///   "title":String("The independence of the continuum hypothesis"),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.set_author("P. J. Cohen2")
/// entry.author() |> ignore() // Some("P. J. Cohen2")
/// ```
pub fn Entry::set_author(self : Entry, author : String) -> Unit {
  self.fields.set("author", Value::String(author))
}

///|
/// Get the editor of the Entry.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "editor":String("P. J. Cohen"),
///   "title":String("The independence of the continuum hypothesis"),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.editor() |> ignore() // Some("P. J. Cohen")
/// ```
pub fn Entry::editor(self : Entry) -> String? {
  match self.fields.get("editor") {
    Some(Value::String(editor)) => Some(editor)
    _ => None
  }
}

///|
/// Set the editor of the Entry.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "editor":String("P. J. Cohen"),
///   "title":String("The independence of the continuum hypothesis"),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.set_editor("P. J. Cohen2")
/// entry.editor() |> ignore() // Some("P. J. Cohen2")
/// ```
pub fn Entry::set_editor(self : Entry, editor : String) -> Unit {
  self.fields.set("editor", Value::String(editor))
}

///|
/// Get the title of the Entry.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "title":String("The independence of the continuum hypothesis"),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.title() |> ignore() // Some("The independence of the continuum hypothesis")
/// ```
pub fn Entry::title(self : Entry) -> String? {
  match self.fields.get("title") {
    Some(Value::String(title)) => Some(title)
    _ => None
  }
}

///|
/// Set the title of the Entry.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "title":String("The independence of the continuum hypothesis"),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.set_title("The independence of the continuum hypothesis2")
/// entry.title() |> ignore() // Some("The independence of the continuum hypothesis2")
/// ```
pub fn Entry::set_title(self : Entry, title : String) -> Unit {
  self.fields.set("title", Value::String(title))
}

///|
/// Get the year of the Entry.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "year":Digit(1963),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.year() |> ignore() // Some(Digit(1963))
/// ```
pub fn Entry::year(self : Entry) -> Value? {
  self.fields.get("year")
}

///|
/// Set the year of the Entry.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "year":Digit(1963),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.set_year(Digit(1964))
/// entry.year() |> ignore() // Some(Digit(1964))
/// ```
pub fn Entry::set_year(self : Entry, year : Value) -> Unit {
  self.fields.set("year", year)
}

///|
/// Get the address of the Entry.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "address":String("New York"),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.address() |> ignore() // Some("New York")
/// ```
pub fn Entry::address(self : Entry) -> String? {
  match self.fields.get("address") {
    Some(Value::String(address)) => Some(address)
    _ => None
  }
}

///|
/// Set the address of the Entry.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "address":String("New York"),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.set_address("New York2")
/// entry.address() |> ignore() // Some("New York2")
/// ```
pub fn Entry::set_address(self : Entry, address : String) -> Unit {
  self.fields.set("address", Value::String(address))
}

///|
/// Get the booktitle of the Entry.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "booktitle":String("The independence of the continuum hypothesis"),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.booktitle() |> ignore() // Some("The independence of the continuum hypothesis")
/// ```
pub fn Entry::booktitle(self : Entry) -> String? {
  match self.fields.get("booktitle") {
    Some(Value::String(booktitle)) => Some(booktitle)
    _ => None
  }
}

///|
/// Set the booktitle of the Entry.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "booktitle":String("The independence of the continuum hypothesis"),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.set_booktitle("The independence of the continuum hypothesis2")
/// entry.booktitle() |> ignore() // Some("The independence of the continuum hypothesis2")
/// ```
pub fn Entry::set_booktitle(self : Entry, booktitle : String) -> Unit {
  self.fields.set("booktitle", Value::String(booktitle))
}

///|
/// Get the chapter of the Entry.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "chapter":Digit(1),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.chapter() |> ignore() // Some(1)
/// ```
pub fn Entry::chapter(self : Entry) -> Int? {
  match self.fields.get("chapter") {
    Some(Value::Digit(chapter)) => Some(chapter)
    _ => None
  }
}

///|
/// Set the chapter of the Entry.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "chapter":Digit(1),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.set_chapter(2)
/// entry.chapter() |> ignore() // Some(2)
/// ```
pub fn Entry::set_chapter(self : Entry, chapter : Int) -> Unit {
  self.fields.set("chapter", Value::Digit(chapter))
}

///|
/// Get the annote of the Entry.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "annote":String("The independence of the continuum hypothesis"),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.annote() |> ignore() // Some("The independence of the continuum hypothesis")
/// ```
pub fn Entry::annote(self : Entry) -> String? {
  match self.fields.get("annote") {
    Some(Value::String(annote)) => Some(annote)
    _ => None
  }
}

///|
/// Set the annote of the Entry.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "annote":String("The independence of the continuum hypothesis"),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.set_annote("The independence of the continuum hypothesis2")
/// entry.annote() |> ignore() // Some("The independence of the continuum hypothesis2")
/// ```
pub fn Entry::set_annote(self : Entry, annote : String) -> Unit {
  self.fields.set("annote", Value::String(annote))
}

///|
/// Get the doi of the Entry.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "doi":String("10.1016/j.jcss.2012.01.001"),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.doi() |> ignore() // Some("10.1016/j.jcss.2012.01.001")
/// ```
pub fn Entry::doi(self : Entry) -> String? {
  match self.fields.get("doi") {
    Some(Value::String(doi)) => Some(doi)
    _ => None
  }
}

///|
/// Set the doi of the Entry.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "doi":String("10.1016/j.jcss.2012.01.001"),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.set_doi("10.1016/j.jcss.2012.01.002")
/// entry.doi() |> ignore() // Some("10.1016/j.jcss.2012.01.002")
/// ```
pub fn Entry::set_doi(self : Entry, doi : String) -> Unit {
  self.fields.set("doi", Value::String(doi))
}

///|
/// Get the edition of the Entry.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "edition":String("1st"),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.edition() |> ignore() // Some("1st")
/// ```
pub fn Entry::edition(self : Entry) -> String? {
  match self.fields.get("edition") {
    Some(Value::String(edition)) => Some(edition)
    _ => None
  }
}

///|
/// Set the edition of the Entry.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "edition":String("1st"),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.set_edition("2nd")
/// entry.edition() |> ignore() // Some("2nd")
/// ```
pub fn Entry::set_edition(self : Entry, edition : String) -> Unit {
  self.fields.set("edition", Value::String(edition))
}

///|
/// Get the howpublished of the Entry.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "howpublished":String("The independence of the continuum hypothesis"),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.howpublished() |> ignore() // Some("The independence of the continuum hypothesis")
/// ```
pub fn Entry::howpublished(self : Entry) -> String? {
  match self.fields.get("howpublished") {
    Some(Value::String(howpublished)) => Some(howpublished)
    _ => None
  }
}

///|
/// Set the howpublished of the Entry.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "howpublished":String("The independence of the continuum hypothesis"),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.set_howpublished("The independence of the continuum hypothesis2")
/// entry.howpublished() |> ignore() // Some("The independence of the continuum hypothesis2")
/// ```
pub fn Entry::set_howpublished(self : Entry, howpublished : String) -> Unit {
  self.fields.set("howpublished", Value::String(howpublished))
}

///|
/// Get the institution of the Entry.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "institution":String("The independence of the continuum hypothesis"),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.institution() |> ignore() // Some("The independence of the continuum hypothesis")
/// ```
pub fn Entry::institution(self : Entry) -> String? {
  match self.fields.get("institution") {
    Some(Value::String(institution)) => Some(institution)
    _ => None
  }
}

///|
/// Set the institution of the Entry.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "institution":String("The independence of the continuum hypothesis"),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.set_institution("The independence of the continuum hypothesis2")
/// entry.institution() |> ignore() // Some("The independence of the continuum hypothesis2")
/// ```
pub fn Entry::set_institution(self : Entry, institution : String) -> Unit {
  self.fields.set("institution", Value::String(institution))
}

///|
/// Get the isbn of the Entry.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "isbn":String("978-3-642-32112-4"),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.isbn() |> ignore() // Some("978-3-642-32112-4")
/// ```
pub fn Entry::isbn(self : Entry) -> String? {
  match self.fields.get("isbn") {
    Some(Value::String(isbn)) => Some(isbn)
    _ => None
  }
}

///|
/// Set the isbn of the Entry.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "isbn":String("978-3-642-32112-4"),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.set_isbn("978-3-642-32112-5")
/// entry.isbn() |> ignore() // Some("978-3-642-32112-5")
/// ```
pub fn Entry::set_isbn(self : Entry, isbn : String) -> Unit {
  self.fields.set("isbn", Value::String(isbn))
}

///|
/// Get the issn of the Entry.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "issn":String("10.1016/j.jcss.2012.01.001"),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.issn() |> ignore() // Some("10.1016/j.jcss.2012.01.001")
/// ```
pub fn Entry::issn(self : Entry) -> String? {
  match self.fields.get("issn") {
    Some(Value::String(issn)) => Some(issn)
    _ => None
  }
}

///|
/// Set the issn of the Entry.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "issn":String("10.1016/j.jcss.2012.01.001"),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.set_issn("10.1016/j.jcss.2012.01.002")
/// entry.issn() |> ignore() // Some("10.1016/j.jcss.2012.01.002")
/// ```
pub fn Entry::set_issn(self : Entry, issn : String) -> Unit {
  self.fields.set("issn", Value::String(issn))
}

///|
/// Get the journal of the Entry.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.journal() |> ignore() // Some("Proceedings of the National Academy of Sciences")
/// ```
pub fn Entry::journal(self : Entry) -> String? {
  match self.fields.get("journal") {
    Some(Value::String(journal)) => Some(journal)
    _ => None
  }
}

///|
/// Set the journal of the Entry.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.set_journal("The independence of the continuum hypothesis2")
/// entry.journal() |> ignore() // Some("The independence of the continuum hypothesis2")
/// ```
pub fn Entry::set_journal(self : Entry, journal : String) -> Unit {
  self.fields.set("journal", Value::String(journal))
}

///|
/// Get the month of the Entry.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "month":String("Jan"),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.month() |> ignore() // Some("Jan")
/// ```
pub fn Entry::month(self : Entry) -> String? {
  match self.fields.get("month") {
    Some(Value::String(month)) => Some(month)
    Some(Value::Month(month)) => Some(month)
    _ => None
  }
}

///|
/// Set the month of the Entry.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "month":String("Jan"),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.set_month("Feb")
/// entry.month() |> ignore() // Some("Feb")
/// ```
pub fn Entry::set_month(self : Entry, month : String) -> Unit {
  self.fields.set("month", Value::String(month))
}

///|
/// Get the note of the Entry.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "note":String("The independence of the continuum hypothesis"),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.note() |> ignore() // Some("The independence of the continuum hypothesis")
/// ```
pub fn Entry::note(self : Entry) -> String? {
  match self.fields.get("note") {
    Some(Value::String(note)) => Some(note)
    _ => None
  }
}

///|
/// Set the note of the Entry.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "note":String("The independence of the continuum hypothesis"),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.set_note("The independence of the continuum hypothesis2")
/// entry.note() |> ignore() // Some("The independence of the continuum hypothesis2")
/// ```
pub fn Entry::set_note(self : Entry, note : String) -> Unit {
  self.fields.set("note", Value::String(note))
}

///|
/// Get the number of the Entry.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "number":Digit(1),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.number() |> ignore() // Some(Digit(1))
/// ```
pub fn Entry::number(self : Entry) -> Value? {
  self.fields.get("number")
}

///|
/// Set the number of the Entry.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "number":Digit(1),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.set_number(Digit(2))
/// entry.number() |> ignore() // Some(Digit(2))
/// ```
pub fn Entry::set_number(self : Entry, number : Value) -> Unit {
  self.fields.set("number", number)
}

///|
/// Get the organization of the Entry.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "organization":String("The independence of the continuum hypothesis"),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.organization() |> ignore() // Some("The independence of the continuum hypothesis")
/// ```
pub fn Entry::organization(self : Entry) -> String? {
  match self.fields.get("organization") {
    Some(Value::String(organization)) => Some(organization)
    _ => None
  }
}

///|
/// Set the organization of the Entry.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "organization":String("The independence of the continuum hypothesis"),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.set_organization("The independence of the continuum hypothesis2")
/// entry.organization() |> ignore() // Some("The independence of the continuum hypothesis2")
/// ```
pub fn Entry::set_organization(self : Entry, organization : String) -> Unit {
  self.fields.set("organization", Value::String(organization))
}

///|
/// Get the pages of the Entry.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "pages":String("100-101"),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.pages() |> ignore() // Some(String("100-101"))
/// ```
pub fn Entry::pages(self : Entry) -> Value? {
  self.fields.get("pages")
}

///|
/// Set the pages of the Entry.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "pages":String("100-101"),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.set_pages(String("100-102"))
/// entry.pages() |> ignore() // Some(String("100-102"))
/// ```
pub fn Entry::set_pages(self : Entry, pages : Value) -> Unit {
  self.fields.set("pages", pages)
}

///|
/// Get the publisher of the Entry.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "publisher":String("The independence of the continuum hypothesis"),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.publisher() |> ignore() // Some("The independence of the continuum hypothesis")
/// ```
pub fn Entry::publisher(self : Entry) -> String? {
  match self.fields.get("publisher") {
    Some(Value::String(publisher)) => Some(publisher)
    _ => None
  }
}

///|
/// Set the publisher of the Entry.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "publisher":String("The independence of the continuum hypothesis"),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.set_publisher("The independence of the continuum hypothesis2")
/// entry.publisher() |> ignore() // Some("The independence of the continuum hypothesis2")
/// ```
pub fn Entry::set_publisher(self : Entry, publisher : String) -> Unit {
  self.fields.set("publisher", Value::String(publisher))
}

///|
/// Get the school of the Entry.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "school":String("The independence of the continuum hypothesis"),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.school() |> ignore() // Some("The independence of the continuum hypothesis")
/// ```
pub fn Entry::school(self : Entry) -> String? {
  match self.fields.get("school") {
    Some(Value::String(school)) => Some(school)
    _ => None
  }
}

///|
/// Set the school of the Entry.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "school":String("The independence of the continuum hypothesis"),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.set_school("The independence of the continuum hypothesis2")
/// entry.school() |> ignore() // Some("The independence of the continuum hypothesis2")
/// ```
pub fn Entry::set_school(self : Entry, school : String) -> Unit {
  self.fields.set("school", Value::String(school))
}

///|
/// Get the type of the Entry.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "type":String("The independence of the continuum hypothesis"),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.type_() |> ignore() // Some("The independence of the continuum hypothesis")
/// ```
pub fn Entry::type_(self : Entry) -> String? {
  match self.fields.get("type") {
    Some(Value::String(type_)) => Some(type_)
    _ => None
  }
}

///|
/// Set the type of the Entry.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "type":String("The independence of the continuum hypothesis"),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.set_type("The independence of the continuum hypothesis2")
/// entry.type_() |> ignore() // Some("The independence of the continuum hypothesis2")
/// ```
pub fn Entry::set_type(self : Entry, type_ : String) -> Unit {
  self.fields.set("type", Value::String(type_))
}

///|
/// Get the series of the Entry.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "series":String("The independence of the continuum hypothesis"),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.series() |> ignore() // Some("The independence of the continuum hypothesis")
/// ```
pub fn Entry::series(self : Entry) -> String? {
  match self.fields.get("series") {
    Some(Value::String(series)) => Some(series)
    _ => None
  }
}

///|
/// Set the series of the Entry.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "series":String("The independence of the continuum hypothesis"),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.set_series("The independence of the continuum hypothesis2")
/// entry.series() |> ignore() // Some("The independence of the continuum hypothesis2")
/// ```
pub fn Entry::set_series(self : Entry, series : String) -> Unit {
  self.fields.set("series", Value::String(series))
}

///|
/// Get the url of the Entry.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "url":String("\\url{https://www.google.com}"),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.url() |> ignore() // Some("\\url{https://www.google.com}")
/// ```
pub fn Entry::url(self : Entry) -> String? {
  match self.fields.get("url") {
    Some(Value::String(url)) => Some(url)
    _ => None
  }
}

///|
/// Set the url of the Entry.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "url":String("\\url{https://www.google.com}"),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.set_url("\\url{https://www.google.com}")
/// entry.url() |> ignore() // Some("\\url{https://www.google.com}")
/// ```
pub fn Entry::set_url(self : Entry, url : String) -> Unit {
  self.fields.set("url", Value::String(url))
}

///|
/// Get the volume of the Entry.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "volume":Digit(1),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.volume() |> ignore() // Some(Digit(1))
/// ```
pub fn Entry::volume(self : Entry) -> Value? {
  self.fields.get("volume")
}

///|
/// Set the volume of the Entry.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "volume":Digit(1),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.set_volume(Digit(2))
/// entry.volume() |> ignore() // Some(Digit(2))
/// ```
pub fn Entry::set_volume(self : Entry, volume : Value) -> Unit {
  self.fields.set("volume", volume)
}

///|
/// Set the value of the Entry.
/// Notice that strongly recommended to use the set_xxx methods instead of this method.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "volume":Digit(1),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.set("volume", Digit(2))
/// ```
pub fn Entry::set(self : Entry, field : String, value : Value) -> Unit {
  self.fields.set(field, value)
}

///|
/// Get the value of the Entry.
/// Notice that strongly recommended to use the get_xxx methods instead of this method.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "volume":Digit(1),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.get("volume") |> ignore() // Some(Digit(1))
/// ```
pub fn Entry::get(self : Entry, field : String) -> Value? {
  self.fields.get(field)
}

///|
/// Remove the field from the Entry.
/// ```mbt
/// let entry = Entry::new(entry_type="article", cite_key="CitekeyArticle", fields={
///   "volume":Digit(1),
///   "journal":String("Proceedings of the National Academy of Sciences"),
/// })
/// entry.remove("volume")
/// entry.get("volume") |> ignore() // None
/// ```
pub fn Entry::remove(self : Entry, field : String) -> Unit {
  self.fields.remove(field)
}
