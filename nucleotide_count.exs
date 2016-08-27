defmodule DNA do
	def count([], x) do
		cond do
			x != ?A and x != ?C and x != ?T and x != ?G -> raise ArgumentError
			true -> 0
		end
	end

	def count([h|r], x) do 
		cond do
			x != ?A and x != ?C and x != ?T and x != ?G -> raise ArgumentError
			h != ?A and h != ?C and h != ?T and h != ?G -> raise ArgumentError
			h == x -> 1 + count(r,x)
			true -> 0 + count(r,x)
		end
	 end

	
	def histogram([]) do %{?A=> 0, ?C=> 0, ?T=> 0, ?G=> 0} end

	def histogram([h|t]) do
		cond do
			h != ?A and h != ?C and h != ?T and h != ?G -> raise ArgumentError
			true ->
				m = histogram(t)
				x = m[h]
				x = x + 1
				%{m| h=>  x}
		end
	end
end