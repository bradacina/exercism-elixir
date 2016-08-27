defmodule Player do
	@doc """
	Starts a new player that will be waiting for messages
	"""
	def start do
		spawn_link(fn -> loop([]) end)
	end

	def take_cards(player, cards) do
		send(player, {:take, cards})
	end

	def battle(player) do
		send(player, {:battle, self})
		receive do
			reply -> reply
		end
	end

	def war(player) do
		send(player, {:war, self})
		receive do
			reply -> reply
		end
	end

	
	# loop that handles messages
	defp loop(cards) do
		receive do
			{:take, newCards} -> 
				cards = take(newCards, cards)
				loop(cards)
			{:battle, game} -> 
				{reply, cards} = battlep(cards)
				send(game, reply)
				loop(cards)
			{:war, game} ->
				{reply, cards} = warp(cards)
				send(game, reply)
				loop(cards)
			_anything -> 0	# we're done, don't loop
		end
	end

	
	# take some newCards and add them to existing cards
	defp take([], cards) do
		cards
	end

	defp take(newCards, cards) do
		take_helper(newCards, Enum.reverse(cards)) |> Enum.reverse
	end

	defp take_helper([], cards), do: cards

	defp take_helper([h|t], cards) do
		take_helper(t, [h | cards])
	end

	# do battle with other players (return top card)
	defp battlep([]), do: {nil, []}

	defp battlep([h|t] = _cards), do: {h, t}

	#Go to war with other players.
	#Will return 3 cards from all cards, 2 with face down, one with face up.
	#The third card is actually at the beginning of the list
	defp warp([]), do: {[], []}

	defp warp(cards) do
		warp(cards, [])
	end

	defp warp([], accum), do: {accum, []}

	defp warp([h|t], accum) do
		cond do
			length(accum) == 3 -> {accum, [h|t]}
			true -> warp(t, [h | accum])
		end
	end
end