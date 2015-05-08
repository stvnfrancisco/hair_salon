require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/stylist")
require("./lib/client")
require("pg")

DB = PG.connect({:dbname => "hair_salon"})

get('/') do
  erb(:index)
end

get('/stylists') do
  @all_stylists = Stylist.all()
  erb(:stylists)
end

get('/new_stylist') do
  stylist_name = params.fetch("stylist_name")
  Stylist.new({:name => stylist_name, :id => nil}).save()
  @all_stylists = Stylist.all()
  erb(:stylists)
end

get('/stylist/:id') do
  @stylist_list = Stylist.find(params.fetch('id').to_i())
  @all_clients = Client.all
  erb(:stylist)
end

patch('/stylist/:id') do
  @stylist_list = Stylist.find(params.fetch("id").to_i)
  client_ids = params.fetch("client_ids", [])
  @stylist_list.update({:client_ids => client_ids})
  binding.pry
  @all_clients = Client.all()
  erb(:single_stylist)
end

get('/clients') do
  @all_clients = Client.all()
  erb(:clients)
end

post('/stylists') do
  name = params.fetch("name")
  new_stylist = Stylist.new({:name => name, :id => nil})
  new_stylist.save()
  @stylists = Stylist.all()
  erb(:stylists)
end

get('/stylist/:id/new') do
  @stylist = Stylist.find(params.fetch('id'))
  erb(:client_form)
end

post('/stylist/:id') do
  name = params.fetch("name")
  stylist_id = params.fetch("id").to_i
  new_client = Client.new({:name => name, :stylist_id => stylist_id, :id => nil})
  new_client.save
  @stylist = Stylist.find(stylist_id)
  erb(:clients)
end
