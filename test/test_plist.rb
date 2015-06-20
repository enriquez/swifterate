require 'minitest_helper'

class TestPList < Minitest::Test

  def setup
    plist_fixture = File.join(File.dirname(__FILE__), 'fixtures/Info.plist')
    @plist = Swifterate::PList.new(plist_fixture)
  end

  def test_keys
    assert_includes(@plist.keys, "CFBundleName")
    assert_includes(@plist.keys, "CFBundleShortVersionString")
    assert_includes(@plist.keys, "CFBundleVersion")
  end

  def test_swift_enum
    swift_plist_fixture = File.join(File.dirname(__FILE__), 'fixtures/InfoPlist.swift')
    assert_equal(@plist.swift_enum, File.read(swift_plist_fixture))
  end

  def test_swift_template_override_name
    swift_plist_fixture = File.join(File.dirname(__FILE__), 'fixtures/MyPlistEnum.swift')
    assert_equal(@plist.swift_enum("MyPlistEnum"), File.read(swift_plist_fixture))
  end

end
