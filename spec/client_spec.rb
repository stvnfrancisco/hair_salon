require('rspec')
require('pg')
require('client')
require("spec_helper")

DB = PG.connect({:dbname => 'hair_salon'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM clients *;")
  end
end

describe(Client) do

  describe(".all") do
      it("is empty at first") do
        expect(Client.all()).to(eq([]))
      end
    end

    describe("#name") do
      it("tells you its name") do
        client = Client.new({:description => "Bob Billy", :id => nil})
        expect(client.name()).to(eq("Bob Billy"))
      end
    end

    describe("#id") do
      it("sets an ID when you save it") do
        client = Client.new({:description => "Bob Billy", :id => nil})
        client.save()
        expect(client.id()).to(be_an_instance_of(Fixnum))
      end
    end

    describe("#save") do
      it("adds a client to the database") do
        client = Client.new({:description => "Bob Billy", :id => nil})
        client.save()
        expect(Client.all()).to(eq([test_client]))
      end
    end

  describe("#==") do
    it("is the same client if it has the same description") do
      client1 = Client.new({:description => "Bob Billy", :id => nil})
      client2 = Client.new({:description => "Bob Billy", :id => nil})
      expect(client1).to(eq(client2))
    end
  end

  describe(".find") do
  it("returns a list by its ID") do
    test_client = Client.new({:name => "Bob Billy", :id => nil})
    test_client.save()
    test_client2 = Client.new({:name => 'Jon Jimmy', :id => nil})
    test_client2.save()
    expect(Client.find(test_client2.id())).to(eq(test_client2))
  end
end
end
