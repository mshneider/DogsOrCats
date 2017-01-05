module GuessHelper
	def self.is_positive_integer?(str)
		return /\A\d+\z/.match(str)
	end

	def self.generate_likes(guess)

		# in Sqlite, booleans are 0 and 1, so we have to sort descending on confirmed column
		bestGuess = Guess.where.not(likes: nil)
			.order("confirmed DESC, ABS(height - #{guess.height}) ASC, ABS(weight - #{guess.weight}) ASC")
			.limit(1).first

		if (bestGuess == nil)
			# randomly pick Dogs or Cats
			guess.likes = ["Dogs", "Cats"].sample
		else
			guess.likes = bestGuess.likes
		end
	end
end
