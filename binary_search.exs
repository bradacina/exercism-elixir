defmodule BinarySearch do
	def search([], _), do: :not_found

	def search(a,b) do
		cond do
			Enum.sort(a) != a -> raise ArgumentError, message: "expected list to be sorted"
			true -> doSearch(a, b, 0)
		end
	end

	def doSearch([], _, _), do: :not_found

	def doSearch(a, b, idx) do
		middleIdx = div length(a), 2
		middle = Enum.at(a, middleIdx)
		cond do
			middle == b -> {:ok, middleIdx + idx}
			middle < b -> doSearch( secondHalf(a, middle), b, middleIdx+1)
			middle > b -> doSearch( firstHalf(a, middle), b, idx)
		end
	end

	def secondHalf(a, middle) do
		{head, tail} = Enum.partition(a, &(middle < &1))
		head
	end

	def firstHalf(a, middle) do
		{head, tail } = Enum.partition(a, &(middle > &1))
		head
	end
end