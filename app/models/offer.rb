class Offer < ActiveRecord::Base
	has_many :vote_options
	validates :topic, presence: true

	scope :visible, -> { where(visible: true) }
	scope :unvisible, -> { where(visible: false) }

	def normalized_votes_for(option)
    	votes_summary == 0 ? 0 : ((option.votes_count.to_f / votes_summary) * 100).round(1)
  	end

	def vote_summary
		vote_options.inject(0) { |sum, opt| sum + opt.votes_count }
	end

end
