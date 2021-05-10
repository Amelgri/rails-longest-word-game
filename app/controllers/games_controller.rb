require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @grid = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @answer = params[:answer].upcase.chars
    # ["C", "E", "R", "C"]
    @grid = params[:grid].gsub(' ', '').chars

    resulte = @answer.all? { |letter| @answer.count(letter) <= @grid.count(letter) }

    if resulte
      response = URI.open("https://wagon-dictionary.herokuapp.com/#{@question}")
      json = JSON.parse(response.read)
      @answer = if json['found'] == true
                  'bravoo'
                else
                  'ça existe pas'
                end
    else
      @answer = 'tu triches'
    end
  end
end
