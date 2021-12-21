require_relative '../lib/classes.rb'

describe 'Customer' do

    before(:each) do
        @cust_name = Customer.new("name")
    end

    it "should be an instance of a Customer" do
        # cust_name = Customer.new("name")
        expect(@cust_name).to be_a(Customer)
    end

    it "should have a name property" do
        expect(@cust_name.name).to eq("name")
    end

    it "should have order hash" do
        expect(@cust_name.order).to be_an_instance_of(Hash)
    end

    it "should have order hash" do
        expect(@cust_name.order_cost).to be_an_instance_of(Hash)
    end

end

describe "NoNameError" do
    it "should raise error if called" do
        expect{raise NoNameError}.to raise_error(NoNameError)
    end
end 