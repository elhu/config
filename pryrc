# Load plugins (only those I whitelist)
Pry.config.should_load_plugins = false
Pry.plugins["doc"].activate!

Pry.hooks = { :after_session => proc { puts "Pry has ended." } }

Pry.prompt = [proc { |obj, nest_level, _| "#{RUBY_VERSION} (#{obj}):#{nest_level} > " }, proc { |obj, nest_level, _| "#{RUBY_VERSION} (#{obj}):#{nest_level} * " }]

# Launch Pry with access to the entire Rails stack.
# If you have Pry in your Gemfile, you can pass: ./script/console --irb=pry instead.
# If you don't, you can load it through the lines below :)
rails = File.join Dir.getwd, 'config', 'environment.rb'

if File.exist?(rails) && ENV['SKIP_RAILS'].nil?
  require rails

  if Rails.version[0..0] == "2"
    require 'console_app'
    require 'console_with_helpers'
  elsif Rails.version[0..0] == "3"
    require 'rails/console/app'
    require 'rails/console/helpers'
  else
    warn "[WARN] cannot load Rails console commands (Not on Rails2 or Rails3?)"
  end
end

#require 'hirb'

#Hirb.enable
#
#old_print = Pry.config.print
#Pry.config.print = proc do |output, value|
#  Hirb::View.view_or_page_output(value) || old_print.call(output, value)
#end
#
#Hirb::View.resize(Hirb::View.width - 25, Hirb::View.height - 5)
#
#module Hirb
#  module Console
#    def vv(o)
#      view(o, :vertical => true)
#    end
#  end
#end
#extend Hirb::Console

require 'yaml'

module YAML
  def self.dump_file(obj, file)
    File.open(file, "w") do |f|
      f.write(YAML::dump(obj))
    end
  end
end

class Array
  def self.toy(n=10, &block)
    block_given? ? Array.new(n,&block) : Array.new(n) {|i| i+1}
  end
end

class Hash
  def self.toy(n=10)
    Hash[Array.toy(n).zip(Array.toy(n){|c| (96+(c+1)).chr})]
  end
end

begin
  require "pryrc_project.rb"
rescue LoadError
  p "No custom pryrc file loaded for the project"
end

if Object.const_defined?('ActiveRecord')
  ActiveRecord::Base.logger = Logger.new(STDOUT)
end
if Object.const_defined?('Mongoid')
  Mongoid.logger = Logger.new(STDOUT)
end

# TODO
# How do I add to all models automatically - ie. extend Mongoid::Document
# ? Identity.f("twitter|gheorghe") will find identities with my either gheorghe or twitter
# ? Identity.f("twitter&gheorghe") will find my twitter identity
# Can be used as: class Model; extend DevHelpers; end  
module DevHelpers
  def f(needle)
    searches = self.fields.keys.map { |field| Hash[field, needle] }
    self.any_of(*searches)
  end
end
