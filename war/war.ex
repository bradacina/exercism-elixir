defmodule War do
	use Application

	def start(_type,_args) do
		IO.puts "in main"
		pid = Game.start
		{:ok, pid}
	end
end
