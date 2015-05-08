class Client

  attr_reader(:name, :id, :stylist_id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attribute.fetch(:id)
    @stylist_id = attributes.fetch(:stylist_id)
  end

  define_singleton_method(:all) do
    returned_clients = DB.exec("SELECT * FROM clients;")
    clients = []
    returned_clients.each() do |client|
      name = client.fetch("name")
      stylist_id = client.fetch("stylist_id").to_i
      id = client.fetch("id").to_i()
      clients.push(Client.new({:name => name, :stylist_id => stylist_id, :id => id}))
    end
    clients
  end


  define_method(:save) do
    DB.exec("INSERT INTO clients (name) VALUES ('#{@name}', #{@stylist_id}) RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  define_method(:==) do |another_client|
    self.name().==(another_client.name()).&(self.stylist_id().==(another_client.stylist_id()))
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    @id = self.id()
    @stylist_id = attributes.fetch(:stylist_id, 1)
    DB.exec("UPDATE clients SET name = '#{@name}' WHERE id = #{@id};")
    client_ids = attributes.fetch(:client_ids, [])
    client_ids.each do |client_id|
      client = Client.find(client_id)
      client.update(:stylist_id => @id)
    end
  end

  define_method(:delete) do
    DB.exexc("Delete from clients WHERE id = #{self.id()};")
  end
end
