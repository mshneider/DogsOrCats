require 'test_helper'

class GuessControllerTest < ActionDispatch::IntegrationTest
  test "index page renders correctly" do
    get "/"
    assert_response :success
    assert_select "div#index-page"
    assert_nil flash[:notice]
    assert_nil flash[:error]
  end

  test "submit with empty height" do
    post "/guess/submit", params: { height: "", weight: "140" }
    assert_response :bad_request
    assert_equal "Height and weight are required!", @response.body
    assert_nil flash[:notice]
    assert_nil flash[:error]
  end

  test "submit with empty weight" do
    post "/guess/submit", params: { height: "70", weight: nil }
    assert_response :bad_request
    assert_equal "Height and weight are required!", @response.body
    assert_nil flash[:notice]
    assert_nil flash[:error]
  end

  test "submit with invalid height" do
    post "/guess/submit", params: { height: "XXX", weight: "140" }
    assert_response :bad_request
    assert_equal "Height and weight must be positive numbers!", @response.body
    assert_nil flash[:notice]
    assert_nil flash[:error]
  end

  test "submit with invalid weight" do
    post "/guess/submit", params: { height: "70", weight: "One hundred pounds" }
    assert_response :bad_request
    assert_equal "Height and weight must be positive numbers!", @response.body
    assert_nil flash[:notice]
    assert_nil flash[:error]
  end

  test "submit with valid height and weight" do
   	# create one guess, just so that we're guaranteed to show "cats" instead of "dogs"
   	guess = Guess.create(height: 68, weight: 130, likes: "Cats", confirmed: true)

    post "/guess/submit", params: { height: "70", weight: "150" }
    assert_response :success
    response_body = JSON.parse(@response.body)
    assert_equal guess.id + 1, response_body["guessId"]
    assert_equal "Cats", response_body["likes"]
    assert_nil flash[:notice]
    assert_nil flash[:error]
  end

  test "confirm with empty guessId" do
    guess = Guess.create(height: 68, weight: 130, likes: "Cats", confirmed: false)

    put "/guess/confirm", params: { guessId: "", confirmed: "true" }
    assert_response :bad_request
    assert_equal "Guess id and confirmed are required!", @response.body
    assert_nil flash[:notice]
    assert_nil flash[:error]
  end

  test "confirm with empty confirmed" do
    guess = Guess.create(height: 68, weight: 130, likes: "Cats", confirmed: false)

    put "/guess/confirm", params: { guessId: guess.id, confirmed: nil }
    assert_response :bad_request
    assert_equal "Guess id and confirmed are required!", @response.body
    assert_nil flash[:notice]
    assert_nil flash[:error]
  end

  test "confirm with confirmed = true" do
   	guess = Guess.create(height: 68, weight: 130, likes: "Cats", confirmed: false)

    put "/guess/confirm", params: { guessId: guess.id, confirmed: true }
    assert_response :success
    assert_equal "", @response.body
    assert_nil flash[:notice]
    assert_nil flash[:error]

    checkGuess = Guess.find(guess.id)
    assert checkGuess.confirmed
  end

  test "confirm with confirmed = false" do
   	guess = Guess.create(height: 68, weight: 130, likes: "Cats", confirmed: false)

    put "/guess/confirm", params: { guessId: guess.id, confirmed: false }
    assert_response :success
    assert_equal "", @response.body
    assert_nil flash[:notice]
    assert_nil flash[:error]

    checkGuess = Guess.find(guess.id)
    assert !checkGuess.confirmed
  end

end
