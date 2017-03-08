# -*- encoding: utf-8 -*-
# stub: clearance 1.15.1 ruby lib

Gem::Specification.new do |s|
  s.name = "clearance".freeze
  s.version = "1.15.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Dan Croak".freeze, "Eugene Bolshakov".freeze, "Mike Burns".freeze, "Joe Ferris".freeze, "Nick Quaranto".freeze, "Josh Nichols".freeze, "Matt Jankowski".freeze, "Josh Clayton".freeze, "Gabe Berke-Williams".freeze, "Greg Lazarev".freeze, "Mike Breen".freeze, "Prem Sichanugrist".freeze, "Harlow Ward".freeze, "Ryan McGeary".freeze, "Derek Prior".freeze, "Jason Morrison".freeze, "Galen Frechette".freeze, "Josh Steiner".freeze]
  s.date = "2016-10-06"
  s.description = "Rails authentication & authorization with email & password.".freeze
  s.email = "support@thoughtbot.com".freeze
  s.extra_rdoc_files = ["LICENSE".freeze, "README.md".freeze]
  s.files = ["LICENSE".freeze, "README.md".freeze]
  s.homepage = "http://github.com/thoughtbot/clearance".freeze
  s.licenses = ["MIT".freeze]
  s.rdoc_options = ["--charset=UTF-8".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.2".freeze)
  s.rubygems_version = "2.6.8".freeze
  s.summary = "Rails authentication & authorization with email & password.".freeze

  s.installed_by_version = "2.6.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<bcrypt>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<email_validator>.freeze, ["~> 1.4"])
      s.add_runtime_dependency(%q<rails>.freeze, [">= 3.1"])
    else
      s.add_dependency(%q<bcrypt>.freeze, [">= 0"])
      s.add_dependency(%q<email_validator>.freeze, ["~> 1.4"])
      s.add_dependency(%q<rails>.freeze, [">= 3.1"])
    end
  else
    s.add_dependency(%q<bcrypt>.freeze, [">= 0"])
    s.add_dependency(%q<email_validator>.freeze, ["~> 1.4"])
    s.add_dependency(%q<rails>.freeze, [">= 3.1"])
  end
end
