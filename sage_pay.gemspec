# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "sage_pay"
  s.version = "1.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Graeme Mathieson", "Bartłomiej Oleszczyk", "Piotr Gębala"]
  s.date = "2013-07-05"
  s.description = "This is a Ruby library for integrating with SagePay. SagePay is a payment\ngateway for accepting credit card payments through your web app.\n"
  s.email = "mathie@woss.name"
  s.extra_rdoc_files = ["README.md", "LICENSE"]
  # s.files = [".rbenv-version", ".rspec", "CHANGELOG.md", "Gemfile", "LICENSE", "README.md", "Rakefile", "TODO", "config/locales/en.yml", "lib/sage_pay.rb", "lib/sage_pay/locale_initializer.rb", "lib/sage_pay/server.rb", "lib/sage_pay/direct.rb", "lib/sage_pay/direct/registration.rb", "lib/sage_pay/direct/card_details.rb", "lib/sage_pay/server/abort.rb", "lib/sage_pay/server/address.rb", "lib/sage_pay/server/authorise.rb", "lib/sage_pay/server/cancel.rb", "lib/sage_pay/server/command.rb", "lib/sage_pay/server/notification.rb", "lib/sage_pay/server/notification_response.rb", "lib/sage_pay/server/refund.rb", "lib/sage_pay/server/refund_response.rb", "lib/sage_pay/server/registration.rb", "lib/sage_pay/server/registration_response.rb", "lib/sage_pay/server/related_transaction.rb", "lib/sage_pay/server/release.rb", "lib/sage_pay/server/repeat.rb", "lib/sage_pay/server/repeat_response.rb", "lib/sage_pay/server/response.rb", "lib/sage_pay/server/signature_verification_details.rb", "lib/sage_pay/server/transaction_code.rb", "lib/sage_pay/uri_fixups.rb", "lib/sage_pay/validators.rb", "lib/sage_pay/version.rb", "sage_pay.gemspec", "spec/integration/sage_pay/server_spec.rb", "spec/sage_pay/server/address_spec.rb", "spec/sage_pay/server/notification_response_spec.rb", "spec/sage_pay/server/notification_spec.rb", "spec/sage_pay/server/registration_response_spec.rb", "spec/sage_pay/server/registration_spec.rb", "spec/sage_pay/server/signature_verification_details_spec.rb", "spec/sage_pay/server/transaction_code_spec.rb", "spec/sage_pay/server_spec.rb", "spec/sage_pay_spec.rb", "spec/spec_helper.rb", "spec/support/factories.rb", "spec/support/integration.rb", "spec/support/validation_matchers.rb"]
  s.homepage = "http://github.com/bbucek/sage_pay"
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.2")
  s.rubyforge_project = "sage_pay"
  s.rubygems_version = "2.0.0"
  s.summary = "Ruby implementation of the SagePay payment gateway protocol."
  s.test_files = ["spec/integration/sage_pay/server_spec.rb", "spec/sage_pay/server/address_spec.rb", "spec/sage_pay/server/notification_response_spec.rb", "spec/sage_pay/server/notification_spec.rb", "spec/sage_pay/server/registration_response_spec.rb", "spec/sage_pay/server/registration_spec.rb", "spec/sage_pay/server/signature_verification_details_spec.rb", "spec/sage_pay/server/transaction_code_spec.rb", "spec/sage_pay/server_spec.rb", "spec/sage_pay_spec.rb"]

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
