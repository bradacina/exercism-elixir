require IEx

defmodule RunLengthEncoder do

	def encode w do
		encode(w, "", 0, "")
	end
	
	defp encode(<<_::size(0)>>, _, 0, accum), do: accum
	
	defp encode(<<_::size(0)>>, ch, count, accum), do: accum <> to_string(count) <> ch

	defp encode w, ch, count, accum do
		{h, t} = String.next_grapheme w
		cond do
			ch == "" -> encode(t, h, 1, accum)
			h == ch -> encode(t, ch, count + 1, accum)
			true -> encode(t, h, 1, accum <> to_string(count) <> ch)
		end
	end

	@groups ~r/[1-9]+[0-9]*[A-Z]/

	@nums ~r/[1-9]+[0-9]*/

	@letters ~r/[A-Z]/

	def decode(<<_::size(0)>>), do: ""

	def decode w do
		Regex.scan(@groups, w) 
		|> Enum.map(&hd/1)
		|> Enum.map_join(&decodeGroup/1)
		
	end

	defp decodeGroup a do
		String.duplicate( hd(Regex.run(@letters, a)), String.to_integer( hd(Regex.run(@nums, a))))
	end
end