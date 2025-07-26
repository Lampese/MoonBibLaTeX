///|
fn to_value(value : InnerValue, string_map : Map[String, InnerValue]) -> Value {
  match value {
    String(value) => Value::String(value)
    Digit(value) => Value::Digit(value)
    Month(value) => Value::Month(value)
    ToValue(value) =>
      match string_map.get(value).unwrap() {
        String(value) => Value::String(value)
        Digit(value) => Value::Digit(value)
        Month(value) => Value::Month(value)
        ToValue(value) => to_value(ToValue(value), string_map)
      }
  }
}

///|
fn transfrom(
  entries : Array[InnerEntry],
  string_defines : Array[StringDefine],
) -> Bibliography {
  let string_map = Map::from_array(
    string_defines.map(x => (x.string_name, x.value)),
  )
  {
    entries: Map::from_array(
      entries.map(entry => (
        entry.cite_key,
        Entry::{
          entry: entry.entry.to_lower(),
          cite_key: entry.cite_key,
          fields: Map::from_iter(
            entry.fields
            .iter()
            .map(x => (x.0.to_lower(), to_value(x.1, string_map))),
          ),
        },
      )),
    ),
  }
}
