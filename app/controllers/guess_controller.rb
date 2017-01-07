class GuessController < ApplicationController

  def submit
  	height = params[:height]
    weight = params[:weight]

    # validate both values passed in
    if (height.blank? || weight.blank?)
    	logger.error "Height and weight required"
      return render plain: "Height and weight are required!", status: :bad_request
    end

    # validate both values positive integers
    if (!GuessHelper.is_positive_integer?(height) || !GuessHelper.is_positive_integer?(weight))
    	logger.error "Height and weight must be positive integers"
    	return render plain: "Height and weight must be positive numbers!", status: :bad_request
    end

    # create a new guess record
    guess = Guess.new(height: height.to_i, weight: weight.to_i, confirmed: false)

    # run the algorithm to compute the likes field
    GuessHelper.generate_likes(guess)    

    # persist the record to the database
    guess.save

    return render :json => { guessId: guess.id, likes: guess.likes }
  end

  def confirm
    guess_id = params[:guessId]
    confirmed = params[:confirmed]

    if (guess_id.blank? || confirmed.nil?)
      logger.error "guessId and confirmed are required"
      return render plain: "Guess id and confirmed are required!", status: :bad_request
    end

    # get the Guess in the database with that id
    guess = Guess.find(guess_id)

    # update the confirmed value
    guess.confirmed = confirmed
      
    # save it
    guess.save

    return head :ok
  end

end
