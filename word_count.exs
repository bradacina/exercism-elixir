defmodule Words do
	@vsn "2"

	@delim [",","!"," ","&","@","$","^","_", "%",":"]

	def count(words) do
		String.split(words,@delim, trim: true) 
		|> Enum.map(&(String.downcase(&1))) 
		|> Words.count(%{})
	end

	def count([], acc), do: acc

	def count([h|t], acc) do
		Words.count(t, Map.update(acc, h, 1, &(&1+1)))
	end
end