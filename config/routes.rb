Rails.application.routes.draw do
  root 'users#index'

  post 'select_user',
    :controller => 'users',
    :action     => 'select_user'
end
