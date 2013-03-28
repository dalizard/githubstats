class Actor < ActiveRecord::Base
  has_many :events
  attr_accessible :name
end
