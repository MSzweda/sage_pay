require 'spec_helper'

if run_integration_specs?
  describe SagePay::Direct, "integration specs" do
    before(:each) do
      SagePay::Direct.default_registration_options = {
        :mode => :direct_simulator,
        :vendor => ENV["VENDOR_NAME"]
      }
    end

    after(:each) do
      SagePay::Direct.default_registration_options = {}
    end

    describe ".payment" do
      before(:each) do
        @payment = SagePay::Direct.payment(
          :description => "Demo payment",
          :amount => 12.34,
          :currency => "GBP",
          :card_details => card_details_factory,
          :billing_address => address_factory
        )
      end

      it "should successfully register the payment with SagePay" do
        @payment.run!.should_not be_nil
      end

      it "should be a valid registered payment" do
        registration = @payment.run!
        registration.should be_ok
      end

      it "should have a next URL" do
        registration = @payment.run!
        registration.next_url.should_not be_nil
      end

      it "should allow us to follow the next URL and the response should be successful" do
        registration = @payment.run!
        uri = URI.parse(registration.next_url)
        request = Net::HTTP::Get.new(uri.request_uri)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true if uri.scheme == "https"
        http.start { |http|
          http.request(request)
        }
      end

      it "should allow us to retrieve signature verification details" do
        @payment.run!
        sig_details = @payment.signature_verification_details

        sig_details.should_not                be_nil
        sig_details.security_key.should_not   be_nil
        sig_details.vendor.should_not         be_nil
      end
    end

    describe ".payment with a US address" do
      before(:each) do
        @payment = SagePay::Direct.payment(
          :description => "Demo payment",
          :amount => 12.34,
          :currency => "GBP",
          :card => card_factory,
          :billing_address => address_factory(:country => "US", :state => "WY")
        )
      end

      it "should successfully register the payment with SagePay" do
        @payment.run!.should_not be_nil
      end

      it "should be a valid registered payment" do
        registration = @payment.run!
        registration.should be_ok
      end

      it "should have a next URL" do
        registration = @payment.run!
        registration.next_url.should_not be_nil
      end

      it "should allow us to follow the next URL and the response should be successful" do
        registration = @payment.run!
        uri = URI.parse(registration.next_url)
        request = Net::HTTP::Get.new(uri.request_uri)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true if uri.scheme == "https"
        http.start { |http|
          http.request(request)
        }
      end

      it "should allow us to retrieve signature verification details" do
        @payment.run!
        sig_details = @payment.signature_verification_details

        sig_details.should_not                be_nil
        sig_details.security_key.should_not   be_nil
        sig_details.vendor.should_not         be_nil
      end
    end

    describe ".deferred" do
      before(:each) do
        @deferred = SagePay::Direct.deferred(
          :description => "Demo payment",
          :amount => 12.34,
          :currency => "GBP",
          :card => card_factory,
          :billing_address => address_factory
        )
      end

      it "should successfully register the deferred payment with SagePay" do
        @deferred.run!.should_not be_nil
      end

      it "should be a valid deferred payment" do
        registration = @deferred.run!
        registration.should be_ok
      end

      it "should have a next URL" do
        registration = @deferred.run!
        registration.next_url.should_not be_nil
      end

      it "should allow us to follow the next URL and the response should be successful" do
        registration = @deferred.run!
        uri = URI.parse(registration.next_url)
        request = Net::HTTP::Get.new(uri.request_uri)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true if uri.scheme == "https"
        http.start { |http|
          http.request(request)
        }
      end

      it "should allow us to retrieve signature verification details" do
        @deferred.run!
        sig_details = @deferred.signature_verification_details

        sig_details.should_not                be_nil
        sig_details.security_key.should_not   be_nil
        sig_details.vendor.should_not         be_nil
      end
    end
  end
end
