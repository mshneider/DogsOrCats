Rails.application.routes.draw do
  get 'guess/ask'
  post 'guess/do_ask'
  
  post 'guess/do_confirm'

  root 'guess#ask'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
