require 'cfpropertylist'
require 'mustache'

module Swifterate
  class PList

    def initialize(file)
      plist = CFPropertyList::List.new(file: file)
      @data = CFPropertyList.native_types(plist.value)
    end

    def keys
      @data.keys
    end

    def swift_enum(name = "InfoPlist")
      template_file = File.join(File.dirname(__FILE__), 'templates/InfoPlist.swift.mustache')
      Mustache.render(File.read(template_file), name: name, keys: keys)
    end

  end
end
