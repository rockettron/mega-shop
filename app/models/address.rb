class Address < ActiveRecord::Base
	belongs_to :profile
	belongs_to :order

	validates :postcode, numericality: true, length: { is: 6 }
	validates :postcode, :address, :profile_id, presence: true

	scope :default, ->{ find_by_default(true) }

	before_create ->{ self.default = true if Address.where(profile: profile).empty? }

	def full_address
		"#{postcode}, #{@address}"
	end

end