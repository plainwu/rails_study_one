class Event < ApplicationRecord
	validates_presence_of :name
	has_many :attendees # 複數
	belongs_to :category, :optional => true
	has_one :location # 單數
	has_many :event_groupships
    has_many :groups, :through => :event_groupships
end
