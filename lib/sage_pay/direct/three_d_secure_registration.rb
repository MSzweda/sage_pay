module SagePay
  module Direct
    class ThreeDSecureRegistration < SagePay::Utils::Command
      attr_accessor :pa_res, :md

      validates_presence_of :pa_res, :md

      validates_length_of :pa_res, maximum: 7500
      validates_length_of :md, maximum: 35

      # TODO: validate format of md and pa_res

      def response_from_response_body(response_body)
        SagePay::Direct::RegistrationResponse.from_response_body(response_body)
      end

      def post_params
        raise ArgumentError, "Invalid transaction registration options (see errors hash for details)" unless self.md.present? && self.pa_res.present?
        {
          "MD"        => self.md,
          "PARes"     => self.pa_res
        }
      end

      def url
        case mode.to_sym
        when :direct_simulator
          "https://test.sagepay.com/Simulator/VSPDirectCallback.asp"
        when :server_simulator
          "https://test.sagepay.com/Simulator/VSPDirectCallback.asp"
        when :test
          "https://test.sagepay.com/gateway/service/direct3dcallback.vsp"
        when :live
          "https://live.sagepay.com/gateway/service/direct3dcallback.vsp"
        else
          raise ArgumentError, "Invalid transaction mode"
        end
      end
    end
  end
end
