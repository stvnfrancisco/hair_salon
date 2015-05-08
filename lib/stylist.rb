class Stylist

  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attribute.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_stylists = DB.exec("SELECT * FROM stylists;")
    stylists = []
    returned_stylists.each() do |stylist|
      name = stylist.fetch("name")
      id = stylist.fetch("id").to_i()
      stylists.push(Stylist.new({:name => name, :id => id}))
    end
    stylists
  end

  define_method(:save) do
    DB.exec("INSERT INTO stylists (name) VALUES ('#{@name}',) RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  define_method(:==) do |another_stylist|
    self.name().==(another_stylist.name()).&(self.id().==(another_stylist_id()))
  end

  define_singleton_method(:find) do |stylist_id|
    search_stylist = nil
    Stylist.all().each() do |stylist|
      if stylist.id() == stylist_id
        search_stylist = stylist
      end
    end
    search_stylist
  end

  define_method(:clients) do
    returned_clients = []
    db_clients = DB.exec("SELECT * FROM clients WHERE stylist_id = #{self.id()} ORDER BY name ASC")
    db_clients.each() do |client|
      name = client.fetch("name")
      stylist_id = client.fetch("stylist_id").to_i
      returned_clients.push(Client.new({name: name, stylist_id: stylist_id}))
    end
    returned_clients
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    @id = self.id()
    DB.exec("UPDATE stylists SET name = '#{@name}' WHERE id = #{@id};")
    client_ids = attributes.fetch(:client_ids, [])
    client_ids.each do |client_id|
      client = Client.find(client_id)
      client.update(:stylist_id => @id)
    end
  end

  define_method(:delete) do
    DB.exec("DELETE FROM stylists WHERE id = #{self.id()};")
  end

end
