require 'minitest/autorun'
require 'github/client'

module Github
  class ClientTest < MiniTest::Unit::TestCase
    attr_reader :sample_json

    def setup
      @sample_json = File.read 'test/assets/dalizard.json'
    end

    def test_dalizard
      tc = self
      sample = sample_json
      klass = Class.new(Client) do
        define_method(:get) do |username|
          tc.assert_equal 'dalizard', username
          sample
        end
      end
      events = klass.fetch 'dalizard'
      assert_operator events.length, :>, 0
    end

    def test_checksum
      sample = sample_json
      klass = Class.new(Client) do
        define_method(:get) do |username|
          sample
        end
      end
      events = klass.fetch 'dalizard'
      assert events.first['checksum'], 'needs a checksum'
      checksums = events.map {|e| e['checksum']}
      assert_equal events.length, checksums.uniq.length
    end
  end
end
