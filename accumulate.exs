defmodule Accumulate do
	def accumulate([],_), do: []

	def accumulate([h|t], f) do
		[f.(h)] ++ accumulate(t, f)
	end
end