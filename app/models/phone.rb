class Phone < ActiveRecord::Base
	belongs_to :profile
	belongs_to :order

	PHONE_REGEX = /\A[+?\d\ \-x\(\)]{7,}\z/

	validates :number, format: { with: PHONE_REGEX }
	validates :number, :profile_id, presence: true

	scope :default, ->{ find_by_default(true) }

	before_create ->{ self.default = true if Phone.where(profile: profile).empty? }

end
