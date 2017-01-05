require 'test_helper'

class GuessHelperTest < ActionView::TestCase
	
  test "simple tests for GuessHelper.is_positive_integer?" do
  	assert_not GuessHelper.is_positive_integer?(nil)
    assert_not GuessHelper.is_positive_integer?("")
    assert GuessHelper.is_positive_integer?("123")
    assert_not GuessHelper.is_positive_integer?("abc")
    assert_not GuessHelper.is_positive_integer?("123abc")
  end

  test "generate_likes with no guesses gives random results" do
  	numCats = 0
  	numDogs = 0

  	guess = Guess.new(height: 70, weight: 140, likes: nil, confirmed: false)
  	for i in 0...20
  		GuessHelper.generate_likes(guess)
  		if (guess.likes == "Cats")
  			numCats = numCats + 1
  		elsif (guess.likes == "Dogs")
  			numDogs = numDogs + 1
  		else
  			fail "Expected Cats or Dogs"
  		end	
  	end

  	assert numCats > 0
  	assert numDogs > 0
  end

  test "generate_likes with only one guess" do
  	numCats = 0
  	numDogs = 0

  	Guess.create(height: 70, weight: 140, likes: "Cats", confirmed: false)

  	guess = Guess.new(height: 70, weight: 140, likes: nil, confirmed: false)
  	for i in 0...20
  		GuessHelper.generate_likes(guess)
  		if (guess.likes == "Cats")
  			numCats = numCats + 1
  		elsif (guess.likes == "Dogs")
  			numDogs = numDogs + 1
  		else
  			fail "Expected Cats or Dogs"
  		end	
  	end

  	assert_equal 20, numCats
  	assert_equal 0, numDogs
  end

  test "generate_likes uses confirmed guess over unconfirmed" do
  	numCats = 0
  	numDogs = 0

  	Guess.create(height: 70, weight: 140, likes: "Cats", confirmed: false)
  	Guess.create(height: 65, weight: 100, likes: "Dogs", confirmed: true)

  	guess = Guess.new(height: 70, weight: 140, likes: nil, confirmed: false)
  	for i in 0...20
  		GuessHelper.generate_likes(guess)
  		if (guess.likes == "Cats")
  			numCats = numCats + 1
  		elsif (guess.likes == "Dogs")
  			numDogs = numDogs + 1
  		else
  			fail "Expected Cats or Dogs"
  		end	
  	end

  	assert_equal 0, numCats
  	assert_equal 20, numDogs
  end

  test "generate_likes uses closest height after confirmed" do
  	numCats = 0
  	numDogs = 0

  	Guess.create(height: 66, weight: 140, likes: "Cats", confirmed: true)
  	Guess.create(height: 69, weight: 100, likes: "Dogs", confirmed: true)

  	guess = Guess.new(height: 70, weight: 140, likes: nil, confirmed: false)
  	for i in 0...20
  		GuessHelper.generate_likes(guess)
  		if (guess.likes == "Cats")
  			numCats = numCats + 1
  		elsif (guess.likes == "Dogs")
  			numDogs = numDogs + 1
  		else
  			fail "Expected Cats or Dogs"
  		end	
  	end

  	assert_equal 0, numCats
  	assert_equal 20, numDogs
  end

    test "generate_likes uses closest weight after confirmed and height" do
  	numCats = 0
  	numDogs = 0

  	Guess.create(height: 66, weight: 130, likes: "Cats", confirmed: true)
  	Guess.create(height: 66, weight: 120, likes: "Dogs", confirmed: true)

  	guess = Guess.new(height: 70, weight: 140, likes: nil, confirmed: false)
  	for i in 0...20
  		GuessHelper.generate_likes(guess)
  		if (guess.likes == "Cats")
  			numCats = numCats + 1
  		elsif (guess.likes == "Dogs")
  			numDogs = numDogs + 1
  		else
  			fail "Expected Cats or Dogs"
  		end	
  	end

  	assert_equal 20, numCats
  	assert_equal 0, numDogs
  end

end
