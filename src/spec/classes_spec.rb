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

    # it "should generate random customer id" do
    #     @cust_name.cust_id.stub(:rand()
    #     expect(@cust_name.cust_id).to be_a(rand(1000000..9999999))
    # end

    it "should be able to take in orders" do
        @cust_name
    end

end

describe "NoNameError" do
    it "should raise error if called" do
        expect{raise NoNameError}.to raise_error
    end
end 