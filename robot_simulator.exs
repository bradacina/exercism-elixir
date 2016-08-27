defmodule RobotSimulator do

	@directions [:north, :west, :south, :east]
	
	@rotate %{
		north: %{left: :west, right: :east},
		south: %{left: :east, right: :west},
		east: %{left: :north, right: :south},
		west: %{left: :south, right: :north}}

	@instructions ["R","L","A"]

	defmodule Robot do
		defstruct position: {0,0}, direction: :north
	end

	def create, do: %Robot{}

	def create d, p do
		validDirection(d) || validPosition(p) || newRobot(d,p)
	end

	defp newRobot(d, p), do: %Robot{position: p, direction: d}

	defp validDirection d do
		if not Enum.any?(@directions, &(&1 == d)) do 
			{:error, "invalid direction"}
		else
			false
		end
	end

	defp validPosition({x,y}) when is_integer(x) and is_integer(y), do: false

	defp validPosition(_), do: {:error, "invalid position"}

	def position r do
		r.position
	end

	def direction r do
		r.direction
	end

	def simulate(r, ""), do: r

	def simulate r, x do
		{h,t} = String.next_grapheme(x)
		if not Enum.any?(@instructions, &(&1==h)) do 
			{:error, "invalid instruction"}
		else
			r = step(r, h)
			simulate(r, t)
		end
	end

	defp step(r, x) do
		case x do
			"L" -> turn(r, :left)
			"R" -> turn(r, :right)
			"A" -> advance(r)
		end
	end

	defp turn r, d do
		%{r | direction: @rotate[r.direction][d] }
	end

	defp advance r do
		{x,y} = r.position
		case r.direction do
			:north -> %{r| position: { x, y+1}}
			:south -> %{r| position: { x, y-1}}
			:east -> %{r| position: { x+1, y}}
			:west -> %{r| position: { x-1, y}}
		end
	end




end