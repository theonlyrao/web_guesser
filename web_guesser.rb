require 'sinatra'
require 'sinatra/reloader'

number = rand(100)

get '/' do
  "THE SECRET NUMBER IS #{number}"
end
