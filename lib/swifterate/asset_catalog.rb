require 'pathname'

module Swifterate
  class AssetCatalog

    CATALOG_EXTENSION = ".xcassets"
    ASSET_EXTENSION = ".imageset"

    def initialize(directory)
      directory = Pathname.new(directory)
      @catalog_name = directory.basename(CATALOG_EXTENSION).to_s
      @asset_dirs = directory.children.select { |dir| dir.directory? && dir.extname == ASSET_EXTENSION }
    end

    def assets
      @asset_dirs.map { |dir| dir.basename(ASSET_EXTENSION).to_s }
    end

    def members
      Helper.enum_members(assets)
    end

    def swift_extension(name = @catalog_name + "Asset")
      template_file = File.join(File.dirname(__FILE__), 'templates/UIImageExtensions.swift.mustache')
      Mustache.render(File.read(template_file), name: name, members: members)
    end

  end
end
