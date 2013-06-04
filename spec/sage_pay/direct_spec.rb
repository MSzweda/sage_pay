require 'spec_helper'

describe SagePay::Direct do
  describe ".payment" do
    before(:each) do
      SagePay::Direct.default_registration_options = {
        :mode => :test,
        :vendor => 'dummyvendor'
      }
    end

    after(:each) do
      SagePay::Server.default_registration_options = {}
    end

    it "should pass in the default registration options" do

      payment = SagePay::Direct.payment
      payment.mode.should             == :test
      payment.vendor.should           == 'dummyvendor'
    end

    it "should generate a vendor transaction code automatically" do
      payment = SagePay::Direct.payment
      payment.vendor_tx_code.should_not be_nil
    end

    it "should set the transaction type to :payment" do
      payment = SagePay::Direct.payment
      payment.tx_type.should == :payment
    end

    it "should duplicate the billing address to the delivery address if no billing address is supplied" do
      address = mock("Home address")

      payment = SagePay::Direct.payment :billing_address => address
      payment.delivery_address.should == address
    end

    it "should not overwrite a delivery address if one is supplied" do
      billing_address = mock("Billing address")
      delivery_address = mock("Delivery address")

      payment = SagePay::Direct.payment :billing_address => billing_address, :delivery_address => delivery_address
      payment.delivery_address.should == delivery_address
      payment.billing_address.should  == billing_address
    end

    it "should allow the caller to override any of the default registration options" do
      payment = SagePay::Direct.payment :vendor => "chickens"
      payment.vendor.should == "chickens"
    end

    it "should allow the caller to override any of the calculated default registration options (eg vendor tx code)" do
      payment = SagePay::Direct.payment :vendor_tx_code => "chickens"
      payment.vendor_tx_code.should == "chickens"
    end

    it "should generate a valid payment given the minimum set of fields" do
      address = address_factory
      card = card_details_factory
      payment = SagePay::Direct.payment(
        :description => "Demo payment",
        :amount => 12.34,
        :currency => "GBP",
        :card_details => card,
        :billing_address => address
      )
      payment.should be_valid
    end
  end
end
