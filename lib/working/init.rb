# encoding: utf-8
module Working
  def self.cli_plain argv
    fail RAILS_TODO_APOLOGY if is_rails?
    Working::PlainInitializer.new.run argv
  end

  def self.is_rails?; File.exists? 'config/environment.ru' end

  class Initializer
    RAILS_TODO_APOLOGY = <<-EOT
No automatic setup for Rails, yet. ☹
Try mimicking https://github.com/rking/monkeynote
# Basically, it'll be:
# test/test_helper.rb
#   %{require 'working/rails_test_helper'},
#   %{# Spork.prefork doesn't like when this is missing},
# Gemfile
#   %{group :development do\n   gem 'pry-rails'\nend},
# Guardfile
#   require 'working/guard-rails'
    EOT

    def run argv
      unless Dir.exists? 'test'
        heading 'mkdir', 'test'
        Dir.mkdir 'test'
      end
      @contents.each do |path, content|
        if File.exist? path
          heading 'found', path
        else
          heading 'create', path
          File.write path, ''
        end
        existing = File.read path
        content.each do |line|
          next if existing[line]
          puts line
          File.write path, line + "\n", mode: 'a'
        end
      end
    end

    def initialize contents
      (@contents ||= {}).merge! contents
    end

    def heading verb, noun
      puts "\e[32m #{verb}\e[0;1m: \e[36;1m#{noun}\e[0m ".center 60, ?—
    end

  end

  require 'date'
  class PlainInitializer < Initializer
    def initialize
      super(
        'Gemfile' => [
          'source :rubygems',
          %{group :development do\n  gem 'working'\nend},
        ],
        'Guardfile' => [
          %{require 'working/guard'},
        ],
        'Rakefile' => [
          %{require 'working/rake_tasks'}
        ],
          'test/test_helper.rb' => [
            %{# Run this via 'beg'},
            %{require 'working/test_helper'},
            %{Spork.each_run do\n  Dir['lib/**/*.rb'].each{|e| load e}\nend},
            %{# Spork.prefork doesn't like when this is missing},
        ],
        'LICENSE.txt' => [
          "Copyleft (ↄ) #{Date.today.year} #{ENV['GIT_AUTHOR_NAME']} — CC0/Public Domain."
        ]
      )
    end
  end
end
