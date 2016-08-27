defmodule Bob do
	
	def hey(s) do
		cond do
			String.ends_with?(s,"?") -> "Sure."
			String.trim(s) == "" -> "Fine. Be that way!"
			String.upcase(s) == s and String.downcase(s) != s -> "Whoa, chill out!"
			true -> "Whatever."
		end
	end
end