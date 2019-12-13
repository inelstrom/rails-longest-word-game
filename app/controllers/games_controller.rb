require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = 'Hello'
    grid = ('A'..'Z').to_a + ('A'..'Z').to_a
    @letters = grid.sample(10)
  end

  def count_chars(string, target)
    target.chars.uniq.map { |c| string.count(c) / target.count(c) }.min
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end

  def score
    @grid = params[:letters_grid]
    @neater_grid = @grid.downcase.gsub(/\s+/, '')
    @word = params[:word]
    @english_word = english_word?(@word)
    if count_chars(@neater_grid, @word) > 0 && @english_word == true
      @result = 'Contains letters from the grid, is english'
      @score = count_chars(@neater_grid, @word)
    else
      @result = "Sorry, but #{@word} can't be built out of #{@grid}"
    end
  end
end
