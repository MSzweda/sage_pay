module SagePay
  module Utils
    class Command
      include ActiveModel::Validations

      class_attribute :tx_type, :vps_protocol, :integration_type

      self.vps_protocol = "2.23"

      attr_accessor :mode, :vendor, :vendor_tx_code, :encryption_key, :proxy_url, :proxy_user, :proxy_password

      validates_presence_of :vps_protocol, :mode, :tx_type, :vendor,
        :vendor_tx_code

      validates_length_of :vps_protocol,     :is      => 4
      validates_length_of :vendor,           :maximum => 15
      validates_length_of :vendor_tx_code,   :maximum => 40

      validates_inclusion_of :mode, :allow_blank => true, :in => [ :showpost, :server_simulator, :direct_simulator, :test, :live ]

      def self.decimal_accessor(*attrs)
        attrs.each do |attr|
          attr_reader attr
          define_method("#{attr}=") do |value|
            instance_variable_set("@#{attr}", value.blank? ? nil : BigDecimal.new(value.to_s))
          end
        end
      end

      def initialize(attributes = {})
        attributes.each do |k, v|
          send("#{k}=", v)
        end
      end

      def run!
        @response ||= handle_response(post)
      end

      def live_service
        raise NotImplementedError, "Subclass of command implement live_service with tail of the URL used for that command in the test & live systems."
      end

      def simulator_service
        raise NotImplementedError, "Subclass of command implement simulator_service with tail of the URL used for that command in the simulator."
      end

      def url
        url_base = base_url(mode)
        case mode.try(:to_sym)
        when :showpost
          "#{url_base}/showpost/showpost.asp?Service=#{simulator_service}"
        when :direct_simulator
          "#{url_base}/simulator/VSPDirectGateway.asp"
        when :server_simulator
          "#{url_base}/simulator/VSPServerGateway.asp?Service=#{simulator_service}"
        when :test
          "#{url_base}/gateway/service/#{live_service}.vsp"
        when :live
          "#{url_base}/gateway/service/#{live_service}.vsp"
        else
          raise ArgumentError, "Invalid transaction mode #{mode}"
        end
      end


      def post_params
        raise ArgumentError, "Invalid transaction registration options (see errors hash for details)" unless valid?

        {
          "VPSProtocol"        => vps_protocol,
          "TxType"             => tx_type.to_s.upcase,
          "Vendor"             => vendor,
          "VendorTxCode"       => vendor_tx_code,
        }
      end

      def response_from_response_body(response_body)
        Response.from_response_body(response_body)
      end

      private

      def base_url(mode)
        registration_options = if integration_type == :server 
          SagePay::Server.default_registration_options
        elsif integration_type == :direct 
          SagePay::Direct.default_registration_options
        end 
        if registration_options[:proxy_url].present?
          registration_options[:proxy_url]
        else
          if mode == :live
            "https://live.sagepay.com"
          else
            "https://test.sagepay.com"
          end
        end
      end

      def http_base_auth
        registration_options = if integration_type == :server 
          SagePay::Server.default_registration_options
        elsif integration_type == :direct 
          SagePay::Direct.default_registration_options
        end 
        if registration_options[:proxy_user].present? && registration_options[:proxy_password].present?
          [registration_options[:proxy_user], registration_options[:proxy_password]]
        end
      end


      def post
        parsed_uri = URI.parse(url)
        request = Net::HTTP::Post.new(parsed_uri.request_uri)
        request.form_data = post_params
        base_auth_data = http_base_auth
        request.basic_auth *base_auth_data if base_auth_data.present?

        http = Net::HTTP.new(parsed_uri.host, parsed_uri.port)

        if parsed_uri.scheme == "https"
          http.use_ssl = true
          http.verify_mode = OpenSSL::SSL::VERIFY_PEER
          http.ca_file = '/etc/ssl/certs/ca-certificates.crt' if File.exists?('/etc/ssl/certs/ca-certificates.crt')
        end

        http.start { |http|
          http.request(request)
        }
      end

      def handle_response(response)
        case response.code.to_i
        when 200
          response_from_response_body(response.body)
        else
          # FIXME: custom error response would be nice.
          raise RuntimeError, "I guess SagePay doesn't like us today: #{response.inspect}"
        end
      end
    end
  end
end
