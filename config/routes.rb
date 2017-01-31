Rails.application.routes.draw do
  scope '/api' do
    resources :users
    resources :expenses
    post    'sessions'     => 'sessions#create'
    delete  'sessions/:id' => 'sessions#destroy'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
