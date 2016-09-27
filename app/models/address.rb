class Address < ActiveRecord::Base
	belongs_to :profile
	belongs_to :order
	

end
