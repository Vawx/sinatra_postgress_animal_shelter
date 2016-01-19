require 'sinatra'
require 'sinatra/reloader'
also_reload 'lib/**/*.rb'
require './lib/animal'
require './lib/customer'
require 'pg'
require 'pry'

DB = PG.connect({dbname: "animal_shelter_test"})

get '/' do
  @animals = Animal.all
  @customers = Customer.all
  erb :index
end

get '/animals/new' do
  erb :animal_form
end

post '/animals/new' do
  name = params["name"]
  gender = params["gender"]
  type = params["type"]
  breed = params["breed"]
  animal = Animal.new({name: name, gender: gender, type: type, breed: breed})
  animal.save
  redirect '/'
end

get '/customers/new' do
  erb :customer_form
end

post '/customers/new' do
  name = params[:name]
  phone = params[:phone]
  types_preference = params[:types_preference]
  breed_preference = params[:breed_preference]
  customer = Customer.new({name: name, phone: phone, types_preference: types_preference, breed_preference: breed_preference})
  customer.save
  redirect '/'
end

get '/customers/:id' do
  @customer = Customer.find(params[:id].to_i)
  erb :customer
end

get '/customers/:id/connect_animal' do
  @animals = Animal.all
  @customer = Customer.find(params[:id].to_i)
  erb :add_animal
end

get '/animals/:id' do
  @animal = Animal.find(params[:id].to_i)
  erb :animal
end
