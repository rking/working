$:.unshift './lib'

module Working
  README_PATH = 'README.rdoc'

  class << self
    def gemspec args
      require_version_file args[:name]
      Gem::Specification.new do |gem|
        gem.name    = args[:name]
        gem.authors = args[:authors]
        gem.email   = args[:email]
        gem.version = args[:version]

        gem.homepage = 'https://github.com/' + args[:github]

        gem.files       = git_ls_files
        gem.executables = gem.files.grep(%r{^bin/}).map{|f| File.basename f}
        gem.test_files  = gem.files.grep %r{^(test|spec|features)}

        args[:deps].each do |e|
          gem.add_dependency e
        end
      end
    end

    def git_ls_files
      `git ls-files`.split $/
    end

    def require_version_file name
      require name
    end

    def file_snippet path, start_pattern, end_pattern
      desired = []
      File.readlines(path).each do |e|
        return desired.join if e[end_pattern]
        in_desired_region = true if e[start_pattern]
        desired << e if in_desired_region
      end
      desired
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
