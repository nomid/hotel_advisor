class Hotel < ActiveRecord::Base
	belongs_to :user
	has_many :comments

	def get_rating
		comments = self.comments
		if (comments.count == 0)
			return 'not rated'
		end
		summ = 0
		n = 0
		comments.each do |c|
			summ += c.rate
			n += 1
		end
		summ.to_f / n
	end
end
