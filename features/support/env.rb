require 'aruba/cucumber'

# we're testing an executable in our own bin folder so prepend the path
extra_path_folder = File.join(File.expand_path(File.dirname(__FILE__)), '../../bin')
ENV['PATH'] = [extra_path_folder, ENV['PATH']].join(File::PATH_SEPARATOR)
