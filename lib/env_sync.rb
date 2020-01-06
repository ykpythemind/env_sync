require "env_sync/version"
require "yaml"
require 'pathname'

module EnvSync
  class Syncer
    class InvalidFormat < StandardError; end

    class EnvSetting
      attr_reader :target_dir, :content, :env_file_name

      def initialize(opts)
        @target_dir = opts['dir'] || raise(InvalidFormat, "missing target dir")
        @content = opts['content'] || raise(InvalidFormat, "missing content")
        @env_file_name = opts.fetch('file') { '.env' }

        validate!
      end

      def target_env_path
        Pathname.new(target_dir).join(env_file_name)
      end

      def write!
        File.open(target_env_path, "w") do |file|
          file.puts content
        end
      end

      private

      def validate!
        raise InvalidFormat, "target_dir is not exists" unless File.exist?(target_dir)
        raise InvalidFormat, "target_dir is not a directory" unless File.directory?(target_dir)
      end
    end

    def initialize(options={})
      @basic_envfile = (options || {}).fetch(:basic_envfile) { 'env.yaml' }
      @envs = parse_env_file!(File.read(@basic_envfile))
    end

    def sync!
      @envs.each do |env|
        fullpath = env.target_env_path
        if File.exist?(fullpath)
          puts "** Overwrite #{fullpath}"
          puts "Before"
          puts File.read(fullpath)
          puts "---"
        else
          puts "** Write #{fullpath}"
        end

        env.write!
        puts File.read(fullpath)
        puts "Done."
      end
    end

    private

    def parse_env_file!(str)
      yaml = YAML.load(str)
      raise InvalidFormat unless yaml.is_a? Array

      yaml.map { |hash| EnvSetting.new(hash) }
    end
  end
end
