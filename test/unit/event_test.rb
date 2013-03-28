require 'test_helper'

class EventTest < ActiveSupport::TestCase
  def test_import
    records = Github::Client.fetch 'dalizard'

    assert_difference 'Event.count', records.length do
      records.each do |record|
        actor = Actor.find_or_create_by_name 'dalizard'
        Event.create_from_record actor, record
      end
    end
  end
end
