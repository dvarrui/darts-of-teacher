# encoding: utf-8

require 'erb'
require 'yaml'
require_relative 'text_actions'

class Lang
  include TextActions

  attr_accessor :lang

  def initialize(lang='en')
    @lang=lang.to_s

    d=(__FILE__).split("/")
    d.delete_at(-1)
    dirbase=d.join("/")

    filename=File.join(dirbase, "locales", @lang ,"templates.yaml" )
    begin
      @templates=YAML::load(File.new(filename))
    rescue Exception => e
      puts "[ERROR]  Reading YAML file <#{filename}>"
      puts "[ADVISE] Perhaps you use apostrophe into string without \\ character"
      raise e
    end
    filename=File.join( dirbase, "locales", @lang, "connectors.yaml" )
    @connectors=YAML::load(File.new(filename))

    filename=File.join( dirbase, "locales", @lang, "mistakes.yaml" )
    @mistakes=YAML::load(File.new(filename))
  end

end