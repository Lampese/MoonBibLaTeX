///|
pub enum Value {
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
pub struct Entry {
  priv mut entry : String
  priv mut cite_key : String
  priv fields : Map[String, Value]
}

///|
pub fn Entry::new(
  entry_type : String,
  cite_key : String,
  fields~ : Map[String, Value] = {}
) -> Entry {
  { entry: entry_type, cite_key, fields }
}

///|
pub fn Entry::fields(self : Entry) -> Map[String, Value] {
  self.fields
}

///|
pub fn Entry::size(self : Entry) -> Int {
  self.fields.size()
}

///|
pub fn Entry::entry_type(self : Entry) -> String {
  self.entry
}

///|
pub fn Entry::set_entry_type(self : Entry, entry_type : String) -> Unit {
  self.entry = entry_type
}

///|
pub fn Entry::cite_key(self : Entry) -> String {
  self.cite_key
}

///|
pub fn Entry::set_cite_key(self : Entry, cite_key : String) -> Unit {
  self.cite_key = cite_key
}

///|
pub fn Entry::author(self : Entry) -> String? {
  match self.fields.get("author") {
    Some(Value::String(author)) => Some(author)
    _ => None
  }
}

///|
pub fn Entry::set_author(self : Entry, author : String) -> Unit {
  self.fields.set("author", Value::String(author))
}

///|
pub fn Entry::editor(self : Entry) -> String? {
  match self.fields.get("editor") {
    Some(Value::String(editor)) => Some(editor)
    _ => None
  }
}

///|
pub fn Entry::set_editor(self : Entry, editor : String) -> Unit {
  self.fields.set("editor", Value::String(editor))
}

///|
pub fn Entry::title(self : Entry) -> String? {
  match self.fields.get("title") {
    Some(Value::String(title)) => Some(title)
    _ => None
  }
}

///|
pub fn Entry::set_title(self : Entry, title : String) -> Unit {
  self.fields.set("title", Value::String(title))
}

///|
pub fn Entry::year(self : Entry) -> Value? {
  self.fields.get("year")
}

///|
pub fn Entry::set_year(self : Entry, year : Value) -> Unit {
  self.fields.set("year", year)
}

///|
pub fn Entry::address(self : Entry) -> String? {
  match self.fields.get("address") {
    Some(Value::String(address)) => Some(address)
    _ => None
  }
}

///|
pub fn Entry::set_address(self : Entry, address : String) -> Unit {
  self.fields.set("address", Value::String(address))
}

///|
pub fn Entry::booktitle(self : Entry) -> String? {
  match self.fields.get("booktitle") {
    Some(Value::String(booktitle)) => Some(booktitle)
    _ => None
  }
}

///|
pub fn Entry::set_booktitle(self : Entry, booktitle : String) -> Unit {
  self.fields.set("booktitle", Value::String(booktitle))
}

///|
pub fn Entry::chapter(self : Entry) -> Int? {
  match self.fields.get("chapter") {
    Some(Value::Digit(chapter)) => Some(chapter)
    _ => None
  }
}

///|
pub fn Entry::set_chapter(self : Entry, chapter : Int) -> Unit {
  self.fields.set("chapter", Value::Digit(chapter))
}

///|
pub fn Entry::annote(self : Entry) -> String? {
  match self.fields.get("annote") {
    Some(Value::String(annote)) => Some(annote)
    _ => None
  }
}

///|
pub fn Entry::set_annote(self : Entry, annote : String) -> Unit {
  self.fields.set("annote", Value::String(annote))
}

///|
pub fn Entry::doi(self : Entry) -> String? {
  match self.fields.get("doi") {
    Some(Value::String(doi)) => Some(doi)
    _ => None
  }
}

///|
pub fn Entry::set_doi(self : Entry, doi : String) -> Unit {
  self.fields.set("doi", Value::String(doi))
}

///|
pub fn Entry::edition(self : Entry) -> String? {
  match self.fields.get("edition") {
    Some(Value::String(edition)) => Some(edition)
    _ => None
  }
}

///|
pub fn Entry::set_edition(self : Entry, edition : String) -> Unit {
  self.fields.set("edition", Value::String(edition))
}

///|
pub fn Entry::howpublished(self : Entry) -> String? {
  match self.fields.get("howpublished") {
    Some(Value::String(howpublished)) => Some(howpublished)
    _ => None
  }
}

///|
pub fn Entry::set_howpublished(self : Entry, howpublished : String) -> Unit {
  self.fields.set("howpublished", Value::String(howpublished))
}

///|
pub fn Entry::institution(self : Entry) -> String? {
  match self.fields.get("institution") {
    Some(Value::String(institution)) => Some(institution)
    _ => None
  }
}

///|
pub fn Entry::set_institution(self : Entry, institution : String) -> Unit {
  self.fields.set("institution", Value::String(institution))
}

///|
pub fn Entry::isbn(self : Entry) -> String? {
  match self.fields.get("isbn") {
    Some(Value::String(isbn)) => Some(isbn)
    _ => None
  }
}

///|
pub fn Entry::set_isbn(self : Entry, isbn : String) -> Unit {
  self.fields.set("isbn", Value::String(isbn))
}

///|
pub fn Entry::issn(self : Entry) -> String? {
  match self.fields.get("issn") {
    Some(Value::String(issn)) => Some(issn)
    _ => None
  }
}

///|
pub fn Entry::set_issn(self : Entry, issn : String) -> Unit {
  self.fields.set("issn", Value::String(issn))
}

///|
pub fn Entry::journal(self : Entry) -> String? {
  match self.fields.get("journal") {
    Some(Value::String(journal)) => Some(journal)
    _ => None
  }
}

///|
pub fn Entry::set_journal(self : Entry, journal : String) -> Unit {
  self.fields.set("journal", Value::String(journal))
}

///|
pub fn Entry::month(self : Entry) -> String? {
  match self.fields.get("month") {
    Some(Value::String(month)) => Some(month)
    Some(Value::Month(month)) => Some(month)
    _ => None
  }
}

///|
pub fn Entry::set_month(self : Entry, month : String) -> Unit {
  self.fields.set("month", Value::String(month))
}

///|
pub fn Entry::note(self : Entry) -> String? {
  match self.fields.get("note") {
    Some(Value::String(note)) => Some(note)
    _ => None
  }
}

///|
pub fn Entry::set_note(self : Entry, note : String) -> Unit {
  self.fields.set("note", Value::String(note))
}

///|
pub fn Entry::number(self : Entry) -> Value? {
  self.fields.get("number")
}

///|
pub fn Entry::set_number(self : Entry, number : Value) -> Unit {
  self.fields.set("number", number)
}

///|
pub fn Entry::organization(self : Entry) -> String? {
  match self.fields.get("organization") {
    Some(Value::String(organization)) => Some(organization)
    _ => None
  }
}

///|
pub fn Entry::set_organization(self : Entry, organization : String) -> Unit {
  self.fields.set("organization", Value::String(organization))
}

///|
pub fn Entry::pages(self : Entry) -> Value? {
  self.fields.get("pages")
}

///|
pub fn Entry::set_pages(self : Entry, pages : Value) -> Unit {
  self.fields.set("pages", pages)
}

///|
pub fn Entry::publisher(self : Entry) -> String? {
  match self.fields.get("publisher") {
    Some(Value::String(publisher)) => Some(publisher)
    _ => None
  }
}

///|
pub fn Entry::set_publisher(self : Entry, publisher : String) -> Unit {
  self.fields.set("publisher", Value::String(publisher))
}

///|
pub fn Entry::school(self : Entry) -> String? {
  match self.fields.get("school") {
    Some(Value::String(school)) => Some(school)
    _ => None
  }
}

///|
pub fn Entry::set_school(self : Entry, school : String) -> Unit {
  self.fields.set("school", Value::String(school))
}

///|
pub fn Entry::type_(self : Entry) -> String? {
  match self.fields.get("type") {
    Some(Value::String(type_)) => Some(type_)
    _ => None
  }
}

///|
pub fn Entry::set_type(self : Entry, type_ : String) -> Unit {
  self.fields.set("type", Value::String(type_))
}

///|
pub fn Entry::series(self : Entry) -> String? {
  match self.fields.get("series") {
    Some(Value::String(series)) => Some(series)
    _ => None
  }
}

///|
pub fn Entry::set_series(self : Entry, series : String) -> Unit {
  self.fields.set("series", Value::String(series))
}

///|
pub fn Entry::url(self : Entry) -> String? {
  match self.fields.get("url") {
    Some(Value::String(url)) => Some(url)
    _ => None
  }
}

///|
pub fn Entry::set_url(self : Entry, url : String) -> Unit {
  self.fields.set("url", Value::String(url))
}

///|
pub fn Entry::volume(self : Entry) -> Value? {
  self.fields.get("volume")
}

///|
pub fn Entry::set_volume(self : Entry, volume : Value) -> Unit {
  self.fields.set("volume", volume)
}

///|
pub fn Entry::set(self : Entry, field : String, value : Value) -> Unit {
  self.fields.set(field, value)
}

///|
pub fn Entry::get(self : Entry, field : String) -> Value? {
  self.fields.get(field)
}

///|
pub fn Entry::remove(self : Entry, field : String) -> Unit {
  self.fields.remove(field)
}
