# -*- encoding: utf-8 -*-
# stub: dateslices 0.0.4 ruby lib

Gem::Specification.new do |s|
  s.name = "dateslices".freeze
  s.version = "0.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Will Schenk".freeze]
  s.date = "2016-03-29"
  s.description = "A Rails 4 ActiveRecord plugin that adds group_by_day, group_by_month, etc. Not timezone aware, but supports sqlite.".freeze
  s.email = ["will@happyfuncorp.com".freeze]
  s.homepage = "https://github.com/sublimeguile/dateslices".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.8".freeze
  s.summary = "A Rails 4 ActiveRecord plugin that adds group_by_day, group_by_month, etc.".freeze

  s.installed_by_version = "2.6.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>.freeze, ["> 4"])
      s.add_development_dependency(%q<sqlite3>.freeze, [">= 0"])
      s.add_development_dependency(%q<pg>.freeze, [">= 0"])
      s.add_development_dependency(%q<mysql>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec-rails>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec-autotest>.freeze, [">= 0"])
      s.add_development_dependency(%q<autotest-rails>.freeze, [">= 0"])
    else
      s.add_dependency(%q<rails>.freeze, ["> 4"])
      s.add_dependency(%q<sqlite3>.freeze, [">= 0"])
      s.add_dependency(%q<pg>.freeze, [">= 0"])
      s.add_dependency(%q<mysql>.freeze, [">= 0"])
      s.add_dependency(%q<rspec-rails>.freeze, [">= 0"])
      s.add_dependency(%q<rspec-autotest>.freeze, [">= 0"])
      s.add_dependency(%q<autotest-rails>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<rails>.freeze, ["> 4"])
    s.add_dependency(%q<sqlite3>.freeze, [">= 0"])
    s.add_dependency(%q<pg>.freeze, [">= 0"])
    s.add_dependency(%q<mysql>.freeze, [">= 0"])
    s.add_dependency(%q<rspec-rails>.freeze, [">= 0"])
    s.add_dependency(%q<rspec-autotest>.freeze, [">= 0"])
    s.add_dependency(%q<autotest-rails>.freeze, [">= 0"])
  end
end
