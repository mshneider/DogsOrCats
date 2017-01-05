require 'test_helper'

class GuessTest < ActiveSupport::TestCase

  test "all fields valid" do
  	guess = Guess.new(height: 70, weight: 140, likes: "Dogs", confirmed: false)
  	assert guess.valid?
  end

  test "height required" do
  	guess = Guess.new(height: nil, weight: 140, likes: "Dogs", confirmed: false)
  	assert guess.invalid?
  end

  test "height invalid" do
  	guess = Guess.new(height: -74, weight: 140, likes: "Dogs", confirmed: false)
  	assert guess.invalid?
  end

  test "weight required" do
  	guess = Guess.new(height: 74, weight: nil, likes: "Dogs", confirmed: false)
  	assert guess.invalid?
  end

  test "weight invalid" do
  	guess = Guess.new(height: 74, weight: -140, likes: "Dogs", confirmed: false)
  	assert guess.invalid?
  end

  test "likes optional" do
  	guess = Guess.new(height: 74, weight: 140, likes: nil, confirmed: false)
  	assert guess.valid?
  end

  test "likes invalid" do
  	guess = Guess.new(height: 74, weight: 140, likes: "Rabbits", confirmed: false)
  	assert guess.invalid?
  end

  test "confirmed required" do
  	guess = Guess.new(height: 74, weight: 140, likes: "Dogs", confirmed: nil)
  	assert guess.invalid?
  end

end
