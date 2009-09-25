require 'optparse'
require 'yaml'

require 'rack/cluster'
require 'rack/cluster/runner'

module Rack
  module Cluster
    class Command
      def parse_options
        @options = {}
        
        OptionParser.new do |opts|
          opts.banner = "Usage: #{$0} [options] command"

          opts.on('-C', '--config PATH') do |config|
            @options[:config_file] = config
          end

          opts.on("-p", "--port PORT", "use PORT") do |p|
            @options[:port] = p
          end

          opts.on('-E', '--env ENVIRONMENT', 'use ENVIRONMENT for defaults') do |e|
            @options[:environment] = e
          end

          opts.on('-N', '--num-servers INT') do |n|
            @options[:servers] = n
          end

          opts.on('-s', '--server SERVER', 'serve using SERVER (webrick/mongrel)') do |s|
            @options[:server] = s
          end

          opts.on('-P', '--pid FILE', 'file to store PID') do |p|
            @options[:pid_file] = p
          end

          opts.on('-c', '--chdir PATH') do |c|
            @options[:cwd] = c
          end

          opts.on('-u', '--config-ru PATH') do |config_ru|
            @options[:config_ru] = config_ru
          end

          opts.on('-b', '--rackup-bin PATH') do |rackup|
            @options[:rackup] = rackup
          end

          opts.on('-v', '--verbose') do |verbose|
            @options[:verbose] = verbose
          end

          opts.on_tail('-h', '--help', 'Show this message') do
            puts opts
            exit
          end

          opts.on_tail('--version', 'Show version') do
            puts Rack::Cluster::VERSION
            exit
          end

          opts.parse! ARGV
        end

        @command = ARGV.shift
      end

      def run
        runner_commands = ['start', 'stop', 'restart']

        if @options[:config_file]
          options_from_config_file = YAML.load_file(@options[:config_file])
          symbolized_options = Hash[options_from_config_file.map { |k, v| [k.to_sym, v] }]
          @options = symbolized_options.merge(@options)
        end

        if runner_commands.include?(@command)
          Rack::Cluster::Runner.send("#{@command}!", @options)
        end
      end
    end
  end
end
