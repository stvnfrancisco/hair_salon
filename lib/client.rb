class Client

  attr_reader(:description)

  define_method(:initialize) do |attributes|
    @description = attributes.fetch(:description)
  end

  define_singleton_method(:all) do
    returned_clients = DB.exec("SELECT * FROM clients;")
    clients = []
    returned_clients.each() do |client|
      description = client.fetch("description")
      client_id = client.fetch("client_id").to_i()
      client.push(Client.new({:description => description, list_id => list_id}))
    end
    clients
  end

  define_method("#name") do

  define_method(:save) do
    DB.exec("INSERT INTO clients (description, list_id) VALUES ('#{@description}', #{@list_id});")
  end

  define_method(:==) do |another_client|
    self.description().==(another_client.description())
  end
end
