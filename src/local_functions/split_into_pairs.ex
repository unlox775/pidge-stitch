def function(full_story_json) do
  # parse the JSON, which is an array of strings
  {:ok, full_story} = Jason.decode(full_story_json)


  thirds = Enum.map(full_story, &(split_into_thirds(&1)))

  pairs =
    thirds
    # generate a set of all adjacent pairs of strings from the list
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.map(&(split_pairs_for_blending(&1)))

  %{
    "first_start" => thirds |> Enum.at(0) |> elem(0),
    "pairs" => pairs,
    "last_end" => thirds |> Enum.at(-1) |> elem(2),
  }
end

# give me an array of objects where each object looks like this:
# %{
#   "post_one_middle" => "...",
#   "post_one_end" => "...",
#   "post_two_start" => "...",
#   "post_two_middle" => "..."
# }
def split_pairs_for_blending([{_post_one_start, post_one_middle, post_one_end}, {post_two_start, post_two_middle, _post_two_end}]) do
  %{
    "post_one_middle" => post_one_middle,
    "post_one_end" => post_one_end,
    "post_two_start" => post_two_start,
    "post_two_middle" => post_two_middle
  }
end

# will split a string into three parts, keeping full sentences intact
def split_into_thirds(str) do
  total_words = num_words(str)

  sentences = split_into_sentences(str, [])

  # Add to each portion one a at time, overflowing when each section fills up
  Enum.reduce(sentences, {"","",""}, fn sentence, {one, two, three} ->
    cond do
      num_words(one) < total_words / 3 -> {one <> " " <> sentence, two, three}
      num_words(two) < total_words / 3 -> {one, two <> " " <> sentence, three}
      true -> {one, two, three <> " " <> sentence}
    end
  end)
end

def split_into_sentences(str, acc) do
  sentence_end = ~r/([\:\.\!\?]\s*)(\w)/
  case Regex.run(sentence_end, str, return: :index) do
    nil -> acc ++ [str]
    [_,_,{next_string_start,1}] ->
      sentence = binary_part(str, 0, next_string_start)
      rest_of_it = binary_part(str, next_string_start, byte_size(str) - next_string_start)
      acc ++ [sentence] ++ split_into_sentences(rest_of_it, acc)
  end
end

defp num_words(text), do:
  text |> String.split(~r/[^\w\']+/) |> Enum.count
