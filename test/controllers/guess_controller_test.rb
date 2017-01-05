require 'test_helper'

class GuessControllerTest < ActionDispatch::IntegrationTest
  test "ask page renders correctly" do
    get guess_ask_url
    assert_response :success
    assert_select "h4", "Please enter your height and weight, and we will try to guess if you like cats or dogs!"
    assert_nil flash[:notice]
    assert_nil flash[:error]
  end

  test "asking with empty height" do
    post guess_do_ask_url, params: { height: "", weight: "140" }
    assert_response :success
    assert_select "h4", "Please enter your height and weight, and we will try to guess if you like cats or dogs!"
    assert_nil flash[:notice]
    assert_equal "Height and weight are required!", flash[:error]
  end

  test "asking with empty weight" do
    post guess_do_ask_url, params: { height: "70", weight: nil }
    assert_response :success
    assert_select "h4", "Please enter your height and weight, and we will try to guess if you like cats or dogs!"
    assert_nil flash[:notice]
    assert_equal "Height and weight are required!", flash[:error]
  end

  test "asking with invalid height" do
    post guess_do_ask_url, params: { height: "XXX", weight: "140" }
    assert_response :success
    assert_select "h4", "Please enter your height and weight, and we will try to guess if you like cats or dogs!"
    assert_nil flash[:notice]
    assert_equal "Height and weight must be positive numbers!", flash[:error]
  end

  test "asking with invalid weight" do
    post guess_do_ask_url, params: { height: "70", weight: "One hundred pounds" }
    assert_response :success
    assert_select "h4", "Please enter your height and weight, and we will try to guess if you like cats or dogs!"
    assert_nil flash[:notice]
    assert_equal "Height and weight must be positive numbers!", flash[:error]
  end

  test "asking with valid height and weight" do
   	# create one guess, just so that we're guaranteed to show "cats" instead of "dogs"
   	Guess.create(height: 68, weight: 130, likes: "Cats", confirmed: true)

    post guess_do_ask_url, params: { height: "70", weight: "150" }
    assert_response :success
    assert_select "h4", "Please confirm the guess below, it helps us learn!"
    assert_nil flash[:notice]
    assert_nil flash[:error]
    assert_select "p", "We think that you like cats. Is that correct?"
  end

  test "confirm correct" do
   	guess = Guess.create(height: 68, weight: 130, likes: "Cats", confirmed: false)

    post guess_do_confirm_url, params: { guess_id: guess.id, correct: true }
    assert_redirected_to guess_ask_url

    checkGuess = Guess.find(guess.id)
    assert checkGuess.confirmed
  end

  test "confirm incorrect" do
   	guess = Guess.create(height: 68, weight: 130, likes: "Cats", confirmed: false)

    post guess_do_confirm_url, params: { guess_id: guess.id, incorrect: true }
    assert_redirected_to guess_ask_url

    checkGuess = Guess.find(guess.id)
    assert !checkGuess.confirmed
  end

end
