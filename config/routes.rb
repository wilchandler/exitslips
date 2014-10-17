Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get "sign_in", to: "sessions#new"
  end

  root to: 'home#index'
  resources :quizzes do
    resources :sittings, only: [:create]
  end
  resources :sections
  resources :users, except: [:index]

  post "/q/take" => "quizzes#take", as: "quiz_take"

  # resources :teachers
  # resources :students, except: [:index]
  # resources :sections do
  #   resources :quizzes
  #   resources :students
  # end
  # get "/quizzes" => "quizzes#index", as: "quizzes"

end
