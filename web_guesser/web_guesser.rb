require 'sinatra'
require 'sinatra/reloader'
require 'pry'

@@secret_number = rand(100)
@@counter = 5

get '/?:p1?/?:p2?' do
  guess = params["guess"]
  cheat = params["cheat"]
  if @@counter == 0
    make_secret_number
    @@counter = 5
    message = ["You guessed 5 times and have lost. SECRET NUMBER has been reset.", "red"]
  elsif cheat == "true"
    message = ["The SECRET NUMBER is #{@@secret_number}."]
  else
    message = check_guess(guess)
  end
  erb :index, :locals => { number: @@secret_number,
                           message: message[0],
                           color: message[1]}
end

def make_secret_number
  @@secret_number = rand(100)
end

def check_guess(guess)
  @@counter -= 1
  if guess.nil?
    response = ""
    color = "white"
    [response, color]
  elsif guess.to_i > @@secret_number
    if guess.to_i > (@@secret_number + 5)
      response = "Way too high!"
      color = "red"
      [response, color]
    else
      response = "Too high!"
      color = "pink"
      [response, color]
    end
  elsif guess.to_i < @@secret_number
    if guess.to_i < (@@secret_number - 5)
      response = "Way too low!"
      color = "red"
      [response, color]
    else
      response = "Too low!"
      color = "pink"
      [response, color]
    end
  elsif guess.to_i == @@secret_number
    response = "You got it right!\nThe SECRET NUMBER is #{@@secret_number}."
    color = "green"
    @@counter = 5
    make_secret_number
    [response, color]
  end
end
