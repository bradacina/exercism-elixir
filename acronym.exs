defmodule Acronym do
	@punctuation ["-", ",", " "]

	@capitalsRegex ~r/[A-Z]/  

	def abbreviate x do
		String.split(x,@punctuation, trim: true)
		|> Enum.map_join(&(abbWord(&1)))
	end

	defp abbWord y do
		{f,r} = String.next_grapheme(y)
		String.upcase(f) <> caps(r)
	end

	defp caps(w), do: Regex.scan(@capitalsRegex, w) |> to_string
end