require 'swifterate/plist'
require 'swifterate/asset_catalog'

module Swifterate
  class Generator

    def self.plist(input, name = nil)
      plist = PList.new(input)

      if name
        puts plist.swift_enum(name)
      else
        puts plist.swift_enum
      end
    end

    def self.ac(input, name = nil)
      asset_catalog = AssetCatalog.new(input)

      if name
        puts asset_catalog.swift_extension(name)
      else
        puts asset_catalog.swift_extension
      end
    end

  end
end
