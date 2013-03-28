require 'github/client'

class Event < ActiveRecord::Base
  belongs_to :actor
  attr_accessible :type, :actor, :data, :github_created_at, :checksum

  def self.create_from_record actor, record
    create_params = {
      :type              => record['type'],
      :actor             => actor,
      :data              => [Marshal.dump(record)].pack('m'),
      :github_created_at => record['created_at'],
      :checksum          => record['checksum']
    }
    create create_params
  end
end
