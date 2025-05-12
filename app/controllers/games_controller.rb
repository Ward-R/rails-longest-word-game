class GamesController < ApplicationController

  def new
     # TODO: generate random grid of letters
    grid_size = 10
    letters = *('A'..'Z')
    @grid_array = grid_size.times.map { letters.sample }
    return @grid_array
  end

  def score

  end
end
