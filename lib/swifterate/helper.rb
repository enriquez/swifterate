module Swifterate
  class Helper

    def self.enum_members(key_list)
      key_list.map { |key| { member_name: sanitize_swift_member(key), key: key } }
    end

    private

    def self.sanitize_swift_member(key)
      key.gsub(/[^a-z0-9_]/i, '')
    end

  end
end
