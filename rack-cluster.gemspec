# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rack-cluster}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ryan Carmelo Briones"]
  s.date = %q{2009-09-25}
  s.default_executable = %q{rack-cluster}
  s.email = %q{ryan.briones@brionesandco.com}
  s.executables = ["rack-cluster"]
  s.files = ["Rakefile", "bin/rack-cluster", "lib/rack", "lib/rack/cluster.rb", "lib/rack/cluster", "lib/rack/cluster/runner.rb", "lib/rack/cluster/command.rb"]
  s.homepage = %q{http://brionesandco.com/ryanbriones}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.4}
  s.summary = %q{tools for managing multiple rackup processes}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
