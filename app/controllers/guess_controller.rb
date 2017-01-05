class GuessController < ApplicationController

  def ask
  	@guess = Guess.new
  end

  def do_ask
  	height = params[:height]
    weight = params[:weight]

    # create a new Guess object in case there was a validation error
    @guess = Guess.new(height: height, weight: weight)

    # logger.info "height: #{height}"
    # logger.info "weight: #{weight}"

    # validate both values passed in
    if (height.blank? || weight.blank?)
    	logger.error "Height and weight required"
    	flash[:error] = "Height and weight are required!"
    	render :ask
    	return
    end

    # validate both values positive integers
    if (!GuessHelper.is_positive_integer?(height) || !GuessHelper.is_positive_integer?(weight))
    	logger.error "Height and weight must be positive integers"
    	flash[:error] = "Height and weight must be positive numbers!"
    	render :ask
    	return
    end

    # create a new guess record
    @guess = Guess.new(height: height.to_i, weight: weight.to_i, confirmed: false)

    # run the algorithm to compute the likes field
    GuessHelper.generate_likes(@guess)    

    # persist ithe record to the database
    @guess.save

    render :confirm

    # logger.info "Created guess with id: #{@guess.id}"
  end

  def do_confirm
    guess_id = params[:guess_id]

    # get the Guess in the database with that id
    guess = Guess.find(guess_id)

    # update the confirmed value
    if (params[:correct])
      guess.confirmed = true
    elsif (params[:incorrect])
      guess.confirmed = false
    else
      logger.error "Expected either correct or incorrect!"
    end
      
    # save it
    guess.save

    @guess = Guess.new

    flash[:notice] = "Thank you for confirming your guess!"
    redirect_to guess_ask_url

  end

end
