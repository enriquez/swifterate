require 'minitest_helper'

class TestAssetCatalog < Minitest::Test

  def setup
    asset_catalog_fixture = File.join(File.dirname(__FILE__), 'fixtures/MyApp.xcassets')
    @asset_catalog = Swifterate::AssetCatalog.new(asset_catalog_fixture)
  end

  def test_assets
    assert_includes(@asset_catalog.assets, "MyAppLogo")
    assert_includes(@asset_catalog.assets, "PrimaryButton")
    refute_includes(@asset_catalog.assets, "AppIcon")
    refute_includes(@asset_catalog.assets, "LaunchImage")
  end

  def test_members
    assert_equal(@asset_catalog.members, [
      { member_name: "MyAppLogo",     key: "MyAppLogo" },
      { member_name: "PrimaryButton", key: "PrimaryButton" }
    ])
  end

  def test_swift_extension
    swift_extension_fixture = File.join(File.dirname(__FILE__), 'fixtures/UIImageMyAppExtensions.swift')
    assert_equal(@asset_catalog.swift_extension, File.read(swift_extension_fixture))
  end

  def test_swift_extension_override_name
    swift_extension_fixture = File.join(File.dirname(__FILE__), 'fixtures/MyUIImageExtensions.swift')
    assert_equal(@asset_catalog.swift_extension("AssetIdentifier"), File.read(swift_extension_fixture))
  end

end
