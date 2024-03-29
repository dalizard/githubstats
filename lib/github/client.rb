require 'json'
require 'digest/md5'
require 'open-uri'

module Github
  class Client
    def self.fetch username
      new.fetch username
    end

    def fetch username
      records = JSON.parse get username
      records.each do |hash|
        checksum = Digest::MD5.hexdigest Marshal.dump(hash)
        hash['checksum'] = checksum
      end
      records
    end

    private

    def get username
      open("https://github.com/#{username}.json").read
    end
  end
end
