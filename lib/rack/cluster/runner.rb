require 'rack/cluster'

module Rack
  module Cluster
    class Runner
      DEFAULT_OPTIONS = {
        :port => 3000,
        :environment => 'development',
        :servers => 1,
        :server => 'mongrel',
        :pid_file => 'tmp/pids/mongrel.pid',
        :verbose => false,
        :rackup => 'rackup'
      }
      
      def initialize(options = {})
        symbolized_options = Hash[options.map { |k, v| [k.to_sym, v] }]
        @options = DEFAULT_OPTIONS.merge(symbolized_options)
      end

      def self.start!(options = {})
        self.new(options).start
      end

      def self.stop!(options = {})
        self.new(options).stop
      end

      def self.restart!(options = {})
        self.new(options).restart
      end

      def start
        start_port.upto(end_port) do |port|
          if pid_file_for_port_exists?(port) && running_on_port?(port)
            puts "already running on port #{port}"
            next
          end

          if pid_file_for_port_exists?(port) && !running_on_port?(port)
            puts "cleaning up pid file for port #{port}"
            File.unlink(pid_file_for_port(port))
          end

          cmd = "#{@options[:rackup]} -D"
          cmd << " -s #{@options[:server]}"
          cmd << " -E #{@options[:environment]}"
          cmd << " -p #{port}"
          cmd << " -P #{pid_file_for_port(port)}"
          cmd << " #{config_ru}" if config_ru
          
          puts "starting port #{port}"
          puts "#{cmd}" if verbose
          output = `#{cmd}`
          STDERR.puts(output) unless $?.success?
        end
      end

      def stop
        start_port.upto(end_port) do |port|
          if pid_file_for_port_exists?(port) && !running_on_port?(port)
            puts "cleaning up pid file for port #{port}"
            File.unlink(pid_file_for_port(port))
          end

          unless running_on_port?(port)
            puts "no process to stop on port #{port}"
            next
          end

          pid = File.read(pid_file_for_port(port)).to_i

          puts "killing #{port}, pid #{pid}"
          Process.kill("KILL", pid)
        end
      end

      def restart
        stop
        start
      end

      def config_ru
        config_ru_file = @options[:config_ru]
        config_ru_absolute_path = config_ru_file =~ /^\//
        cwd = @options[:cwd]

        if config_ru_file && cwd
          if config_ru_absolute_path
            config_ru_file
          else
            File.join(cwd, config_ru_file)
          end
        elsif config_ru_file
          config_ru_file
        elsif cwd
          File.join(cwd, 'config.ru')
        else
          'config.ru'
        end
      end

      def servers
        @options[:servers].to_i != 0 ? @options[:servers].to_i : 1
      end

      def start_port
        @options[:port].to_i
      end

      def end_port
        start_port + (servers - 1)
      end

      def pid_file_for_port(port)
        return unless @options[:pid_file]

        pid_file_dir = File.dirname(@options[:pid_file])
        pid_file_ext = File.extname(@options[:pid_file])
        pid_file_basename = File.basename(@options[:pid_file], pid_file_ext)
        
        full_pid_file_dir = if @options[:cwd]
                              File.join(@options[:cwd], pid_file_dir)
                            else
                              pid_file_dir
                            end

        File.join(full_pid_file_dir, "#{pid_file_basename}.#{port}#{pid_file_ext}")
      end

      def pid_file_for_port_exists?(port)
        return false unless @options[:pid_file]
        File.exists?(pid_file_for_port(port))
      end

      def running_on_port?(port)
        return false unless pid_file_for_port_exists?(port)

        pid = File.read(pid_file_for_port(port)).to_i
        processes = `ps -p #{pid} -o cmd=`
        
        return true if processes =~ /rackup/
        false
      end

      def verbose
        @options[:verbose]
      end
    end
  end
end
