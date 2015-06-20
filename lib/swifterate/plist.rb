require 'cfpropertylist'
require 'mustache'
require 'swifterate/helper'

module Swifterate
  class PList

    def initialize(file)
      plist = CFPropertyList::List.new(file: file)
      @data = CFPropertyList.native_types(plist.value)
    end

    def keys
      @data.keys
    end

    def members
      Helper.enum_members(keys)
    end

    def swift_enum(name = "InfoPlist")
      template_file = File.join(File.dirname(__FILE__), 'templates/InfoPlist.swift.mustache')
      Mustache.render(File.read(template_file), name: name, members: members)
    end

  end
end
