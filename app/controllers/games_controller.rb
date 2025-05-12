class GamesController < ApplicationController
  require 'open-uri'
  require 'json'

  def new
     # TODO: generate random grid of letters
    grid_size = 10
    letters = *('A'..'Z')
    @grid_array = grid_size.times.map { letters.sample }#only views can see if @, not other methods in this class
  end

  def score
    found = check_dictionary(params[:word])["found"]
    in_grid = grid_check?(params[:word], params[:grid]) #here grid is passed in new with hidden value due to no model yet.

    if in_grid == false
      @result = "The word can’t be built out of the original grid"
    elsif in_grid && !found
      @result = "The word is valid according to the grid, but is not a valid English word"
    elsif found && in_grid
      @result = "Congratulations #{params[:word]} is a valid English word!"
    end
  end

  def check_dictionary(attempt)
    url = "https://dictionary.lewagon.com/#{attempt}"
    attempt_check = URI.parse(url).read
    JSON.parse(attempt_check)
  end

  def grid_check?(attempt, grid)
    attempt.upcase.chars.all? do |letter|
      grid.include?(letter) && attempt.upcase.chars.count(letter) <= grid.count(letter)
    end
  end

end
