defmodule Game do
	
	@cards [2,3,4,5,6,7,8,9,10,"J", "Q", "K","A"]

	#:takecards -> :battle -> :war ([-> :war] | [-> :gameover]) -> :takecards
	#					  -> :takecards
	#					  -> :gameover
	defmodule State do
		defstruct player1: nil, player2: nil
	end

	def start do
		spawn_link(fn -> start_helper() end)
	end

	defp start_helper do
		s = %State{}
		p1 = Player.start
		p2 = Player.start

		s = %{s | player1: p1} 
		s = %{s | player2: p2}

		cards = shuffle(@cards ++ @cards ++ @cards ++ @cards, [])
		{first,sec} = Enum.split(cards, 26)

		take_cards_nogame(p1, first)
		take_cards_nogame(p2, sec)

		battle(s)
	end

	defp shuffle([], acc), do: acc

	defp shuffle(list, acc) do
		{leading, [h | t]} = Enum.split(list, :rand.uniform(Enum.count(list)) - 1)
		shuffle(leading ++ t, [h | acc])
	end

	defp take_cards_nogame(player, cards) do
		Player.take_cards(player, cards)
	end

	#:battle state
	defp battle(state) do
		p1Card = Player.battle(state.player1)
		p2Card = Player.battle(state.player2)
		
		IO.puts "Battle"
		IO.write "P1 -> "
		IO.inspect p1Card
		IO.write "P2 -> "
		IO.inspect p2Card

		receive do
			_ -> nil
		end

		cond do
			nil == p1Card -> gameover("2")
			nil == p2Card -> gameover("1")
			true -> compare_cards(p1Card, p2Card, [p1Card, p2Card], state)
		end
	end

	# compare cards
	defp compare_cards(c1, c2, allCards, state) do
		c1t = translate_card(c1)
		c2t = translate_card(c2)
		cond do
			c1t == c2t -> war(allCards, state)
			c1t < c2t -> take_cards(state.player2, allCards, state)
			true -> take_cards(state.player1, allCards, state)
		end
	end

	# translate the J, Q, K, A cards to their numerical values
	defp translate_card(card) do
		case card do
			"J" -> 11
			"Q" -> 12
			"K" -> 13
			"A" -> 14
			_other -> card
		end
	end

	#:takecards state
	defp take_cards(player, cards, state) do
		
		p = if player == state.player1 do
			"1"
		else
			"2"
		end

		IO.write ("Giving cards to player " <> p)
		IO.inspect cards

		Player.take_cards(player, cards)
		battle(state)
	end

	#:war state
	defp war(cards, state) do
		p1cards = Player.war(state.player1)
		p2cards = Player.war(state.player2)

		IO.puts "WAR"
		IO.write "P1 -> "
		IO.inspect p1cards
		IO.write "P2 -> "
		IO.inspect p2cards

		receive do
			_ -> nil
		end

		cond do
			length(p1cards) != 3 -> gameover("2")
			length(p2cards) != 3 -> gameover("1")
			true ->
				[p1card | p1rest] = p1cards
				[p2card | p2rest] = p2cards
				allCards = cards ++ p1cards ++ p2cards

				compare_cards(p1card, p2card, allCards, state)
		end
	end

	defp gameover(winer) do
		IO.puts "Game is over"
		IO.write "Winner -> Player"
		IO.puts winer
	end

end