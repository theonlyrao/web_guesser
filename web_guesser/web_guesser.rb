require 'sinatra'
require 'sinatra/reloader'
require 'pry'

SECRET_NUMBER = rand(100)

get '/' do
  guess = params["guess"]
  message = check_guess(guess)
  erb :index, :locals => { number: SECRET_NUMBER,
                           message: message }
end

def check_guess(guess)
  if guess.nil?
    response = ""
  elsif guess.to_i > SECRET_NUMBER
    if guess.to_i > (SECRET_NUMBER + 5)
      response = "Way too high!"
    else
      response = "Too high!"
    end
    response
  elsif guess.to_i < SECRET_NUMBER
    if guess.to_i < (SECRET_NUMBER - 5)
      response = "Way too low!"
    else
      response = "Too low!"
    end
    response
  elsif guess.to_i == SECRET_NUMBER
    response = "You got it right!\nThe SECRET NUMBER is #{SECRET_NUMBER}."
  end
end
