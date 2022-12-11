# frozen_string_literal: true

require "decidim/gem_manager"

namespace :decidim_alternative_landing do
  namespace :webpacker do
    desc "Installs Alternative Landing files in Rails instance application"
    task install: :environment do
      raise "Decidim gem is not installed" if decidim_path.nil?

      install_alternative_landing_npm
    end

    desc "Adds Alternative Landing dependencies in package.json"
    task upgrade: :environment do
      raise "Decidim gem is not installed" if decidim_path.nil?

      install_alternative_landing_npm
    end

    def install_alternative_landing_npm
      alternative_landing_npm_dependencies.each do |type, packages|
        puts "install NPM packages. You can also do this manually with this command:"
        puts "npm i --save-#{type} #{packages.join(" ")}"
        system! "npm i --save-#{type} #{packages.join(" ")}"
      end
    end

    def alternative_landing_npm_dependencies
      @alternative_landing_npm_dependencies ||= begin
        package_json = JSON.parse(File.read(alternative_landing_path.join("package.json")))

        {
          prod: package_json["dependencies"].map { |package, version| "#{package}@#{version}" },
          dev: package_json["devDependencies"].map { |package, version| "#{package}@#{version}" }
        }.freeze
      end
    end

    def alternative_landing_path
      @alternative_landing_path ||= Pathname.new(alternative_landing_gemspec.full_gem_path) if Gem.loaded_specs.has_key?(gem_name)
    end

    def alternative_landing_gemspec
      @alternative_landing_gemspec ||= Gem.loaded_specs[gem_name]
    end

    def rails_app_path
      @rails_app_path ||= Rails.root
    end

    def system!(command)
      system("cd #{rails_app_path} && #{command}") || abort("\n== Command #{command} failed ==")
    end

    def gem_name
      "decidim-alternative_landing"
    end
  end
end
