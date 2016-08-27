defmodule SpaceAge do

	@secPerYear 31557600

	@planets %{
		:earth => @secPerYear,
		:mercury => @secPerYear * 0.2408467,
		:venus => @secPerYear * 0.61519726,
		:mars => @secPerYear * 1.8808158,
		:jupiter => @secPerYear * 11.862615,
		:saturn => @secPerYear * 29.447498,
		:uranus => @secPerYear * 84.016846,
		:neptune => @secPerYear * 164.79132
	}

	def age_on(s, w) do
		w / @planets[s]
	end
end