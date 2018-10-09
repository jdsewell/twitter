class Tweet < ApplicationRecord
	belongs_to :user

	has_many :tweet_tags
	has_many :tags, through: :tweet_tags

	before_validation :link_check, on: :create

	validates :message, presence: true
	validates :message, length: {maximum: 140, too_long: "maximum of 140 characters"}

	after_validation :apply_link, on: :create

private

	def link_check
		if self.message.include? "https://"
			arr = self.message.split
			index = arr.map {|x| x.include? "https://"}.index(true)

			self.link = arr[index]

			if arr[index].length > 20
				arr[index] = "#{arr[index][0..18]}..."
			end

			self.message = arr.join(" ")
		end
	end
	def apply_link
		arr = self.message.split
		index = arr.map {|x| x.include? "https://"}.index(true)
		if index
			url = arr[index]
			arr[index] = "<a href='#{self.link}'>#{url}</a>"
		end
		self.message = arr.join(" ")
	end
end

