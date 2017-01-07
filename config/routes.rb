Rails.application.routes.draw do

  post 'guess/submit'
  put 'guess/confirm'

  # main UI page / Angular wrapper
  root 'home#index'

end
