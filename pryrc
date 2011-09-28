# Load plugins (only those I whitelist)
Pry.config.should_load_plugins = false
#Pry.plugins["doc"].activate!

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

require 'hirb'

Hirb.enable

old_print = Pry.config.print
Pry.config.print = proc do |output, value|
  Hirb::View.view_or_page_output(value) || old_print.call(output, value)
end

Hirb::View.resize(Hirb::View.width - 25, Hirb::View.height - 5)

module Hirb
  module Console
    def vv(o)
      view(o, :vertical => true)
    end
  end
end
extend Hirb::Console

Domain.where(:name => "domain-test").first.configure

class Object
  Domain.all.each do |d|
    define_method("d_#{d.name.split('-').map(&:first).join}") { d.configure }
  end
  def d_cur
    Domain.current_domain
  end
  def d_all
    Domain.all.map &:name
  end
end

def update_cs
  ContentSource.last.synchronizer.synchronize
end
