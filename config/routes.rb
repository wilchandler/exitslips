Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get "sign_in", to: "sessions#new"
  end

  root to: 'home#index'

  resources :quizzes do
    resources :sittings, only: [:new, :create]
  end

  resources :sections
  resources :users, except: [:index]

  post "/q/take" => "quizzes#take", as: "quiz_take"
  resources :standards, only: [:index], :defaults => { :format => 'json' }

  get "/quizzes/:id/finished_quiz" => "quizzes#finish", as: "quizzes_finish"

end
