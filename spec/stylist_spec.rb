require("spec_helper")

describe(Stylist) do

  describe("#save") do
    it("adds the stylist to the database") do
      test_stylist = Stylist.new({:name => "Bob Billy", :id => nil})
      test_stylist.save()
      expect(Stylist.all()).to(eq([test_stylist]))
    end
  end

  describe(".find") do
    it("finds a stylist with a matching id and returns them") do
      test_stylist = Stylist.new({:name => 'Bob Billy', :id => nil})
      test_stylist.save()
      test_stylist2 = Stylist.new({:name => 'John jimmy', :id => nil})
      test_stylist2.save()
      expect(Stylist.find(test_stylist2.id())).to(eq(test_stylist2))
    end
  end

  describe('#update') do
    it("lets you update a stylist in the database") do
      test_stylist = Stylist.new({:name => 'Bob Billy', :id => nil})
      test_stylist.save()
      test_stylist.update({:name => 'BillyBob'})
      expect(test_stylist.name()).to(eq('BillyBob'))
    end
  end

  describe('#delete') do
    it("deletes a stylist from the database") do
      test_stylist = Stylist.new({:name => 'Bob', :id => nil})
      test_stylist.save()
      test_stylist2 = Stylist.new({:name => 'Ann', :id => nil})
      test_stylist2.save()
      test_stylist.delete()
      expect(Stylist.all()).to(eq([test_stylist2]))
    end
  end

end
