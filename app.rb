require 'sinatra'
require 'sinatra/reloader'
also_reload 'lib/**/*.rb'
require './lib/animal'
require './lib/customer'
require 'pg'
require 'pry'

DB = PG.connect({dbname: "animal_shelter_test"})

get '/' do
  @animals = Animal.sort_alpha
  @customers = Customer.all
  @breeds = Animal.sort_breeds
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
  @animals = Animal.all
  erb :customer
end

get '/customers/:id/connect_animal' do
  @animals = Animal.all
  @customer = Customer.find(params[:id].to_i)
  erb :add_animal
end

post '/customers/:id/connect_animal/:animal_id' do
  @customer = Customer.find(params[:id].to_i)
  @animal = Animal.find(params[:animal_id].to_i)
  @animal.add_customer(@customer.id.to_i)
  redirect '/customers/' + params[:id]
end

get '/animals/:id' do
  @animal = Animal.find(params[:id].to_i)
  erb :animal
end

get '/breeds/:breed' do
  @breed = params[:breed]
  @animals = Animal.find_by_breed(params[:breed])
  erb :breed
end
