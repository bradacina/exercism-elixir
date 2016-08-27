defmodule Sublist do
	def compare([], []), do: :equal
	def compare([], [_|_]), do: :sublist
	def compare([_|_], []), do: :superlist
	
	def compare(a,b) when length(a) < length(b) do
		r = compare(a, Enum.take(b, length(a)))
		s = compare(a, Enum.take(tl(b), length(a)))
		cond do
			r == :unequal and s == :unequal-> compare(a, tl(b))
			true -> :sublist
		end
	end

	def compare(a,b) when length(a) > length(b) do
		r = compare(Enum.take(a, length(b)), b)
		s = compare(Enum.take( tl(a), length(b)), b)
		cond do
			r == :unequal and s == :unequal -> compare(tl(a), b)
			true -> :superlist
		end
	end

	def compare(a,a), do: :equal
	def compare(_,_), do: :unequal
end