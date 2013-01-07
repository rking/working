require 'working/version'

module Working
  README_PATH = 'README.rdoc'

  class << self
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
