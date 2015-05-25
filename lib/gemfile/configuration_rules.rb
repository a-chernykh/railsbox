module Gemfile
  class ConfigurationRules
    def self.for(gem_name)
      new(gem_name)
    end

    def initialize(gem_name)
      @gem_name = gem_name
      @rule = rules[gem_name]
    end

    def apply(configuration)
      @rule.call(configuration)
    end

    private

    def add_packages(*packages)
      -> (c) do
        c[:packages] += packages
        c[:packages].uniq!
      end
    end

    def add_database(database)
      -> (c) do
        c[:databases] << database
        c[:databases].uniq!
      end
    end

    def remove_database(database)
      -> (c) { c[:databases].delete(database) }
    end

    def add_postgresql_extension(ext)
      -> (c) do
        c[:postgresql_extensions] << ext
        c[:postgresql_extensions].uniq!
      end
    end

    def add_background_job(job)
      -> (c) do
        c[:background_jobs] << job
        c[:background_jobs].uniq!
      end
    end

    def combine(*lambdas)
      -> (c) { lambdas.each { |l| l.call(c) } }
    end

    def rules
      rules = {
        'capybara-webkit' => add_packages('qt5-default', 'libqt5webkit5-dev'),
        'pg'  => add_database('postgresql'),
        'mysql' => combine(add_database('mysql'), remove_database('postgresql')),
        'mysql2' => combine(add_database('mysql'), remove_database('postgresql')),
        'activerecord-postgis-adapter' => combine(add_database('postgresql'), add_postgresql_extension('postgis')),
        'nokogiri' => add_packages('zlib1g-dev'),
        'mini_magick' => add_packages('imagemagick'),
        'sidekiq' => add_background_job('sidekiq'),
        'hiredis' => add_database('redis'),
        'redis' => add_database('redis'),
        'delayed_job_active_record' => add_background_job('delayed_job'),
        'delayed_job_mongoid' => add_background_job('delayed_job'),
        'delayed_job' => add_background_job('delayed_job'),
        'ffi' => add_packages('libffi-dev'),
        'sqlite3' => add_packages('sqlite3', 'libsqlite3-dev'),
      }
      rules.default = -> (c) { }
      rules.freeze
    end
  end
end
