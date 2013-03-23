require 'minitest/autorun'
require 'github/client'

module Github
  class ClientTest < MiniTest::Unit::TestCase
    def test_dalizard
      sample = File.read 'test/assets/dalizard.json'

      tc = self
      klass = Class.new(Client) do
        define_method(:get) do |username|
          tc.assert_equal 'dalizard', username
          sample
        end
      end
      events = klass.fetch 'dalizard'
      assert_operator events.length, :>, 0
    end
  end
end
