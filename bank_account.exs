defmodule BankAccount do
	
	defmodule Account do
		defstruct amount: 0, closed: false
	end

	def open_bank do
		{:ok, pid} = Agent.start_link(fn -> %Account{} end)
		pid
	end

	def close_bank(pid) do
		Agent.update(pid, fn(acc)-> %{acc| closed: true} end)
	end

	def balance pid do
		Agent.get(pid, fn(acc)-> acc.amount end)
	end

	def update pid, amount do
		Agent.update(pid, fn(acc)-> %{acc | amount: acc.amount + amount} end)
	end
end