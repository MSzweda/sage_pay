module SagePay
  module Direct
    class << self
      attr_accessor :default_registration_options
    end
    # NOTE: Expected to be something along the lines of:
    #
    #     SagePay::Server.default_registration_options = {
    #       :mode => :live,
    #       :vendor => "rubaidh",
    #       :notification_url => "http://test.host/notification",
    #       :encryption_key => 'xxxxx'
    #     }
    #
    # ... which you'll want to stick in config/initializers/sage_pay.rb or one
    # of your environment files, if you're doing this with a Rails app.
    self.default_registration_options = {}

    # The notification URL is only relevant to registration options, but the
    # rest are relevant to all requests.
    # FIXME: This should be Hash#only instead of Hash#except!
    def self.default_options
      default_registration_options.except(:notification_url, :profile)
    end

    def self.related_transaction(attributes = {})
      SagePay::Direct::RelatedTransaction.new(attributes)
    end

    def self.payment(attributes = {})
      registration({ :tx_type => :payment }.merge(attributes))
    end

    def self.deferred(attributes = {})
      registration({ :tx_type => :deferred }.merge(attributes))
    end

    def self.authenticate(attributes = {})
      registration({ :tx_type => :authenticate }.merge(attributes))
    end

    def self.registration(attributes)
      defaults = {
        :vendor_tx_code   => SagePay::Utils::TransactionCode.random,
        :delivery_address => attributes[:billing_address]
      }.merge(default_registration_options)

      SagePay::Direct::Registration.new(defaults.merge(attributes))
    end

    def self.release(attributes = {})
      defaults = {
      }.merge(default_options)

      SagePay::Direct::Release.new(defaults.merge(attributes))
    end

    def self.abort(attributes = {})
      defaults = {
      }.merge(default_options)

      SagePay::Direct::Abort.new(defaults.merge(attributes))
    end

    def self.refund(attributes = {})
      defaults = {
        :vendor_tx_code => SagePay::Utils::TransactionCode.random,
      }.merge(default_options)

      SagePay::Direct::Refund.new(defaults.merge(attributes))
    end

    def self.authorise(attributes = {})
      defaults = {
        :vendor_tx_code => SagePay::Utils::TransactionCode.random,
      }.merge(default_options)

      SagePay::Direct::Authorise.new(defaults.merge(attributes))
    end

    def self.cancel(attributes = {})
      defaults = {
      }.merge(default_options)

      SagePay::Direct::Cancel.new(defaults.merge(attributes))
    end

    def self.repeat(attributes = {})
      defaults = {
        :vendor_tx_code => SagePay::Utils::TransactionCode.random,
      }.merge(default_options)

      SagePay::Direct::Repeat.new(defaults.merge(attributes))
    end
  end
end
