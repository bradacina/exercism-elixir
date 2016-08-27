defmodule SumOfMultiples do
	def to(n,m) do
		Enum.map(m, &(multiples(n, &1, 1)))
		|> List.flatten
		|> Enum.uniq
		|> Enum.sum
	end
	
	defp multiples(n,x,c) when x * c >= n, do: []
 
	defp multiples(n,x,c) do
		[x * c | multiples(n,x,c+1)]
	end
end