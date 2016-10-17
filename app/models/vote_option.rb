class VoteOption < ActiveRecord::Base
	belongs_to :offer
	validates :title, presence: true

end

