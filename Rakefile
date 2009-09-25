require 'rake/gempackagetask'

require File.expand_path(File.dirname(__FILE__) + '/lib/rack/cluster')
 
spec = Gem::Specification.new do |s|
  s.name = 'rack-cluster'
  s.version = Rack::Cluster::VERSION
  s.summary = 'tools for managing multiple rackup processes'
  s.files = FileList['[A-Z]*', 'bin/*', 'lib/**/*']
  s.has_rdoc = false
  s.bindir = 'bin'
  s.executables = ['rack-cluster']
  s.author = 'Ryan Carmelo Briones'
  s.email = 'ryan.briones@brionesandco.com'
  s.homepage = 'http://brionesandco.com/ryanbriones'
end
 
Rake::GemPackageTask.new(spec) {}

desc "Build rack-cluster.gemspec"
task :build_gemspec do
  File.open("#{spec.name}.gemspec", "w") do |f|
    f.write spec.to_ruby
  end
end
 
task :default => [:build_gemspec, :gem]
