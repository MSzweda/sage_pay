# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "sage_pay"
  s.version = "1.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Graeme Mathieson", "Bart\u{142}omiej Oleszczyk", "Piotr G\u{119}bala"]
  s.date = "2013-07-05"
  s.description = "This is a Ruby library for integrating with SagePay. SagePay is a payment\ngateway for accepting credit card payments through your web app.\n"
  s.email = "mathie@woss.name"
  s.extra_rdoc_files = ["README.md", "LICENSE"]
  s.files = ["spec/integration/sage_pay/server_spec.rb", "spec/sage_pay/server/address_spec.rb", "spec/sage_pay/server/notification_response_spec.rb", "spec/sage_pay/server/notification_spec.rb", "spec/sage_pay/server/registration_response_spec.rb", "spec/sage_pay/server/registration_spec.rb", "spec/sage_pay/server/signature_verification_details_spec.rb", "spec/sage_pay/server/transaction_code_spec.rb", "spec/sage_pay/server_spec.rb", "spec/sage_pay_spec.rb", "README.md", "LICENSE"]
  s.homepage = "http://github.com/bbucek/sage_pay"
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.2")
  s.rubyforge_project = "sage_pay"
  s.rubygems_version = "2.0.0"
  s.summary = "Ruby implementation of the SagePay payment gateway protocol."
  if s.respond_to? :specification_version then
    s.specification_version = 2

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, [">= 3.1.3"])
      s.add_runtime_dependency(%q<activemodel>, [">= 3.1.0"])
      s.add_runtime_dependency(%q<uuid>, [">= 2.3.0"])
      s.add_runtime_dependency(%q<i18n>, [">= 0.6.0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<activesupport>, [">= 3.1.3"])
      s.add_dependency(%q<activemodel>, [">= 3.1.0"])
      s.add_dependency(%q<uuid>, [">= 2.3.0"])
      s.add_dependency(%q<i18n>, [">= 0.6.0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 3.1.3"])
    s.add_dependency(%q<activemodel>, [">= 3.1.0"])
    s.add_dependency(%q<uuid>, [">= 2.3.0"])
    s.add_dependency(%q<i18n>, [">= 0.6.0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
