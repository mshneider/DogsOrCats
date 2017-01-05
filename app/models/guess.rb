class Guess < ApplicationRecord
	validates :height, presence: true, numericality: { only_integer: true, :greater_than => 0 }
	validates :weight, presence: true, numericality: { only_integer: true, :greater_than => 0 }
	validates :likes, inclusion: { in: %w(Dogs Cats) }, :allow_nil => true
	validates :confirmed, inclusion: { in: [true, false] }
	validates :confirmed, exclusion: { in: [nil] }
end
