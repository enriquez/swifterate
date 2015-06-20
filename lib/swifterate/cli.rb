require 'thor'
require 'swifterate/generator'

module Swifterate
  class CLI < Thor

    desc "plist FILE", "Generate Swift code from the .plist file located at FILE"
    method_option :name, :type => :string, :desc => "The resuling Swift enum name. Defaults to InfoPlist"
    def plist(input)
      Generator.plist(File.expand_path(input), options[:name])
    end

    desc "ac DIR", "Generate Swift code from an Asset Catalog directory located at DIR"
    method_option :name, :type => :string, :desc => "The resuling Swift enum name. Defaults to <Asset Catalog Name>Asset"
    def ac(input)
      Generator.ac(File.expand_path(input), options[:name])
    end

  end
end
