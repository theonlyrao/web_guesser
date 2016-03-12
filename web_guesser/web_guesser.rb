require 'sinatra'
require 'sinatra/reloader'
require 'pry'

@@secret_number = rand(100)
@@counter = 5

get '/?:p1?/?:p2?' do
  guess = params["guess"]
  cheat = params["cheat"]
  response = Response.new(guess, cheat)
  erb :index, :locals => { number: @@secret_number,
                           message: response.message[0],
                           color: response.message[1]}
end

class Response

  attr_reader :message

  def initialize(guess, cheat)
    respond(guess, cheat)
  end

  def respond(guess, cheat)
    if out_of_guesses?
      SecretNumber.make_secret_number
      @@counter = 5
      @message = ["You guessed 5 times and have lost. SECRET NUMBER has been reset.", "red"]
    elsif cheating?(cheat)
      @message = ["The SECRET NUMBER is #{@@secret_number}.", "white"]
    else
      @message = check_guess(guess)
    end
  end

  def out_of_guesses?
    @@counter == 0
  end

  def cheating?(cheat)
    cheat == "true"
  end

  def check_guess(guess)
    @@counter -= 1
    if first_get_request?(guess)
      response = ""
      color = "white"
      [response, color]
    elsif guess_higher_than_secret_number?(guess)
      if by_more_than_five?(guess)
        response = "Way too high!"
        color = "red"
        [response, color]
      else
        response = "Too high!"
        color = "pink"
        [response, color]
      end
    elsif guess_lower_than_secret_number?(guess)
      if by_more_than_five?(guess)
        response = "Way too low!"
        color = "red"
        [response, color]
      else
        response = "Too low!"
        color = "pink"
        [response, color]
      end
    elsif guessed_correctly?(guess)
      response = "You got it right!\nThe SECRET NUMBER is #{@@secret_number}."
      color = "green"
      @@counter = 5
      SecretNumber.make_secret_number
      [response, color]
    end
  end

  def first_get_request?(guess)
    guess.nil?
  end

  def guess_higher_than_secret_number?(guess)
    guess.to_i > @@secret_number
  end

  def guess_lower_than_secret_number?(guess)
    guess.to_i < @@secret_number
  end

  def by_more_than_five?(guess)
    (guess.to_i - @@secret_number).abs > 5
  end

  def guessed_correctly?(guess)
    guess.to_i == @@secret_number
  end
end

class SecretNumber
  def self.make_secret_number
    @@secret_number = rand(100)
  end
end
