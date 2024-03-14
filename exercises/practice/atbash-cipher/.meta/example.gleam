import gleam/dict.{type Dict}
import gleam/list
import gleam/result
import gleam/string

pub fn encode(phrase: String) -> String {
  let encode_map = encoding_map()

  phrase
  |> string.lowercase()
  |> string.to_graphemes()
  |> list.map(fn(char) { dict.get(encode_map, char) })
  |> result.values()
  |> list.sized_chunk(into: 5)
  |> list.map(string.concat)
  |> string.join(with: " ")
}

pub fn decode(phrase: String) -> String {
  phrase
  |> encode()
  |> string.replace(each: " ", with: "")
}

fn encoding_map() -> Dict(String, String) {
  let letters = string.to_graphemes("abcdefghijklmnopqrstuvwxyz")
  let digits = string.to_graphemes("0123456789")

  list.zip(letters, list.reverse(letters))
  |> list.append(list.zip(digits, digits))
  |> dict.from_list()
}
