class Profile < ActiveRecord::Base
	
	has_one :image, as: :imageable
	has_many :addresses
	has_many :phones

	validates :first_name, :last_name, presence: true

end
