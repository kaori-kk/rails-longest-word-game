require 'json'
require 'open-uri'

class GamesController < ApplicationController

  def new
    @letters = []
    a = ('A'..'Z').to_a

    10.times do
      @letters << a.sample
    end
  end

  def score

    @letters = params[:letters].split('')
    @word = params[:word]
    @scores = @word.size * 5

    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    data_serialized = open(url).read
    @data = JSON.parse(data_serialized)


    if !@data["found"]
      @message = "Sorry but #{@word} does not seem to be a valid English word."
    elsif can_be_built?(@word)
      @message = "Congratulations! #{@word} is a valid English word! Your score is #{@scores}"

    else
      @message = "Sorry but TEST can't be built out of #{@letters}"
    end
  end

  def can_be_built?(word)
    each_letter = word.split('')
    each_letter.each do |e|
      unless @letters.include?(e)
        return false
      end
    end
    return true
  end

end
