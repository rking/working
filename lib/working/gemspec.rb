$:.unshift './lib'

module Working
  README_PATH = 'README.rdoc'
  REQUIRED_FIELDS = [
    :name,
    :summary,
    :description,
    :authors,
    :email,
    :version,
    :github,
    :deps,
  ]

  class << self
    def gemspec args
      validate_gem_args! args
      require_version_file args[:name]
      Gem::Specification.new do |gem|
        [ :name, :summary, :authors, :email, :version ].each do |e|
          gem.send "#{e}=", args[e]
        end

        gem.description = gem.summary + "\n\n" + args[:description]

        gem.homepage = 'https://github.com/' + args[:github]

        gem.files       = git_ls_files
        gem.executables = gem.files.grep(%r{^bin/}).map{|f| File.basename f}
        gem.test_files  = gem.files.grep %r{^(test|spec|features)}

        args[:deps].each do |e|
          gem.add_dependency e
        end
      end
    end

    def validate_gem_args! input
      args = input.dup
      missing_fields = REQUIRED_FIELDS.find_all{|e| !args.delete e}
      fail <<-EOT unless args.size.zero?
Working.gem got #{args.keys.join ' and '},
but only expected #{REQUIRED_FIELDS.map(&:to_s).join ', '}
      EOT
      return if missing_fields.size.zero?
      fail "Working.gem needs: #{missing_fields.map(&:to_s).join ', '}"
    end

    def git_ls_files
      `git ls-files`.split $/
    end

    def require_version_file name
      require name
    rescue LoadError
      # Do nothing
    end

    def file_snippet path, start_pattern, end_pattern
      desired = []
      in_desired_region = false
      File.readlines(path).each do |e|
        break if e[end_pattern]
        in_desired_region = true if e[start_pattern]
        desired << e if in_desired_region
      end
      desired.join
    end
    def readme_snippet start_pattern, end_pattern
      file_snippet README_PATH, start_pattern, end_pattern
    end

    def file_third_line path
      File.readlines(path)[2]
    end
    def third_line_of_readme
      file_third_line README_PATH
    end
  end
end
