module SagePay
  module Direct
    class CardDetails
      include ActiveModel::Validations
      include SagePay::Validators

      attr_accessor :card_holder, :card_number, :expiry_date, :card_type,
                    :start_date, :issue_number, :cv2
      validates_inclusion_of :card_type, :in => CREDIT_CARDS,  :allow_blank => false, :message => "is not a valid"

      def initialize(attributes = {})
        attributes.each do |k, v|
          send("#{k}=", v)
        end
      end
    end
  end
end
