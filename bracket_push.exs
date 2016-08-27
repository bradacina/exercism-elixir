defmodule BracketPush do
	def check_brackets s do
		cb( to_charlist(s) |> Enum.map(&([&1])), [])
	end

	def cb([],[]), do: true

	def cb([],[_|_]), do: false

	def cb([a|b], c) when open_bracket?(a), do: cb(b, [a|c])

	def cb([a|b],c) when close_bracket?(a) do
		length(c) > 0 and hd(c) == '{' and cb(b, tl(c))
	end

	def cb([_|b], c) do
		cb(b, c)
	end

	@open_brackets ['(','[','{']
	@close_brackets [')',']','}']
	def open_bracket?(c), do: Enum.any? @open_brackets &(&1 == c)
	def close_bracket?(c), do: Enum.any? @close_brackets &(&1 == c)
end