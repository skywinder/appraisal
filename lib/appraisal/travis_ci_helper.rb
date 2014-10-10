require "appraisal/file"
require "yaml"

module Appraisal
  class TravisCIHelper
    def self.display_instruction
      puts "# Put this in your .travis.yml"
      puts "gemfiles:"
      File.each do |appraisal|
        puts "  - #{appraisal.relative_gemfile_path}"
      end
    end

    def self.validate_configuration_file
      configuration = YAML.load_file(".travis.yml")

      if configuration && !valid_configuration?(configuration)
        $stderr.puts(
          "Warning: Your gemfiles directive in .travis.yml is incorrect. Run " +
            "`appraisal generate --travis` to get the correct configuration."
        )
      else
        $stderr.puts(
          "Note: Run with --travis to generate Travis CI configuration."
        )
      end
    end

    private

    def self.valid_configuration?(configuration)
      if configuration["gemfiles"]
        appraisal_paths = File.new.appraisals.map(&:relative_gemfile_path).sort
        travis_gemfile_paths = configuration["gemfiles"].sort
        puts appraisal_paths
        puts travis_gemfile_paths
        appraisal_paths == travis_gemfile_paths
      end
    end
  end
end
