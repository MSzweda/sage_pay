module SagePay
  module Direct
    class RegistrationResponse < Response
      attr_accessor_if_ok :vps_tx_id, :security_key

      self.key_converter = key_converter.merge({
        "VPSTxId"      => :vps_tx_id,
        "SecurityKey"  => :security_key
      })
    end
  end
end
