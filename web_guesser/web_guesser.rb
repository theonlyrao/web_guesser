require 'sinatra'
require 'sinatra/reloader'
require 'pry'

SECRET_NUMBER = rand(100)

get '/' do
  guess = params["guess"]
  message = check_guess(guess)

  erb :index, :locals => { number: SECRET_NUMBER,
                           message: message[0],
                           color: message[1]}
end

def check_guess(guess)
  if guess.nil?
    response = ""
    color = "white"
    [response, color]
  elsif guess.to_i > SECRET_NUMBER
    if guess.to_i > (SECRET_NUMBER + 5)
      response = "Way too high!"
      color = "red"
      [response, color]
    else
      response = "Too high!"
      color = "pink"
      [response, color]
    end
  elsif guess.to_i < SECRET_NUMBER
    if guess.to_i < (SECRET_NUMBER - 5)
      response = "Way too low!"
      color = "red"
      [response, color]
    else
      response = "Too low!"
      color = "pink"
      [response, color]
    end
  elsif guess.to_i == SECRET_NUMBER
    response = "You got it right!\nThe SECRET NUMBER is #{SECRET_NUMBER}."
    color = "green"
    [response, color]          
  end
end
