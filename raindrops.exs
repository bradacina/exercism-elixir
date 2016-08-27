defmodule Raindrops do
	def convert n do
		r = divisible?(n, 3, "Pling") <> divisible?(n, 5, "Plang") <> divisible?(n, 7, "Plong")
		cond do
			r == "" -> to_string(n)
			true -> r
		end
	end

	def divisible? n, d, w do
		cond do
			rem(n,d) == 0 -> w
			true -> ""
		end
	end
end