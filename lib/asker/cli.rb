# frozen_string_literal: true

require 'rainbow'
require 'thor'
require_relative 'application'
require_relative '../asker'

##
# Command Line User Interface
class CLI < Thor
  map ['h', '-h', '--help'] => 'help'

  map ['f', '-f', '--file'] => 'file'
  desc 'file NAME', 'Build output files, from HAML/XML input file.'
  option :color, type: :boolean
  long_desc <<-LONGDESC
  Create output files, from input file (HAML/XML format).

  Build questions about contents defined into input file specified.

  Examples:

  (1) #{Rainbow('asker input/foo/foo.haml').yellow}, Build questions from HAML file.

  (2) #{Rainbow('asker input/foo/foo.xml').yellow}, Build questions from XML file.

  (3) #{Rainbow('asker file --no-color input/foo/foo.haml').yellow}, Same as (1) but without colors.

  (4) #{Rainbow('asker projects/foo/foo.yaml').yellow}, Build questions from YAML project file.

  LONGDESC
  ##
  # Create questions from input file
  # @param filename (String) Path to input file
  def file(filename)
    # Enable/disable color output
    Rainbow.enabled = false if options['color'] == false
    # Asker start processing input file
    Asker.new.start(filename)
  end

  map ['v', '-v', '--version'] => 'version'
  desc 'version', 'Show the program version'
  ##
  # Show current version
  def version
    print Rainbow(Application::NAME).bright.blue
    puts  " (version #{Rainbow(Application::VERSION).green})"
  end

  map ['i', '-i', '--init'] => 'init'
  desc 'init', 'Create default INI config fie'
  ##
  # Create default INI config file
  def init
    src = File.join(File.dirname(__FILE__), 'files', 'config.ini')
    dst = File.join(Dir.pwd, 'config.ini')
    if File.exist? dst
      puts "[WARN] Exists file! => #{Rainbow(File.basename(dst)).yellow.bright}"
    else
      FileUtils.cp(src, dst)
      puts "[ OK ] Create file  => #{Rainbow(File.basename(dst)).green}"
    end
  end

  ##
  # This actions are equals:
  # * asker demo/foo.haml
  # * asker file demo/fool.haml
  def method_missing(method, *_args, &_block)
    file(method.to_s)
  end
end