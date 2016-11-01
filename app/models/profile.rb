class Profile < ActiveRecord::Base
	has_one :image, as: :imageable
	has_many :addresses, dependent: :destroy
	has_many :phones, dependent: :destroy
	belongs_to :user

	def full_name
      "#{first_name} #{last_name}"
    end

end
