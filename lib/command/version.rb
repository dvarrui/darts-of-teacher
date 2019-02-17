#!/usr/bin/ruby

require_relative '../application'

# Command Line User Interface
class Asker < Thor

  map ['v', '-v', '--version'] => 'version'
  desc 'version', 'show the program version'
  def version
    print Rainbow(Application.name).bright.blue
    puts  ' (version ' + Rainbow(Application.version).green + ')'
  end

end
