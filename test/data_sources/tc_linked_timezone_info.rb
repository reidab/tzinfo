# frozen_string_literal: true

require File.join(File.expand_path(File.dirname(__FILE__)), '..', 'test_utils')

include TZInfo

module DataSources
  class TCLinkedTimezoneInfo < Minitest::Test
    def test_initialize_nil_identifier
      error = assert_raises(ArgumentError) { LinkedTimezoneInfo.new(nil, 'Test/Linked') }
      assert_match(/\bidentifier\b/, error.message)
    end

    def test_initialize_nil_link_to_identifier
      error = assert_raises(ArgumentError) { LinkedTimezoneInfo.new('Test/Zone', nil) }
      assert_match(/\blink_to_identifier\b/, error.message)
    end

    def test_identifier
      lti = LinkedTimezoneInfo.new('Test/Zone', 'Test/Linked')
      assert_equal('Test/Zone', lti.identifier)
      assert(lti.identifier.frozen?)
    end

    def test_link_to_identifier
      lti = LinkedTimezoneInfo.new('Test/Zone', 'Test/Linked')
      assert_equal('Test/Linked', lti.link_to_identifier)
      assert(lti.link_to_identifier.frozen?)
    end

    def test_construct_timezone
      lti = LinkedTimezoneInfo.new('Test/Zone', 'Europe/London')
      tz = lti.create_timezone
      assert_kind_of(LinkedTimezone, tz)
      assert_equal('Test/Zone', tz.identifier)
    end

    def test_inspect
      lti = LinkedTimezoneInfo.new('Test/Zone', 'Europe/London')
      assert_equal('#<TZInfo::DataSources::LinkedTimezoneInfo: Test/Zone>', lti.inspect)
    end
  end
end
