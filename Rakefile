require 'rake/gempackagetask'

require File.expand_path(File.dirname(__FILE__) + '/lib/rack/cluster')
 
spec = Gem::Specification.new do |s|
  s.name = 'rack-cluster'
  s.version = Rack::Cluster::VERSION
  s.homepage = 'http://github.com/ryanbriones/rack-cluster'
  s.summary = 'tools for managing multiple rackup processes'
  s.files = FileList['[A-Z]*', 'bin/*', 'lib/**/*']
  s.has_rdoc = false
  s.bindir = 'bin'
  s.executables = ['rack-cluster']
  s.author = 'Ryan Carmelo Briones'
  s.email = 'ryan.briones@brionesandco.com'

  s.add_runtime_dependency 'rack', '>=1.0.0'
end
 
Rake::GemPackageTask.new(spec) {}

desc "Write out #{spec.name}.gemspec"
task :build_gemspec do
  File.open("#{spec.name}.gemspec", "w") do |f|
    f.write spec.to_ruby
  end
end
 
task :default => [:build_gemspec, :gem]
