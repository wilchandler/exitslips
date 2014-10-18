Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get "sign_in", to: "sessions#new"
  end

  root to: 'home#index'
  resources :enrollments,only: [:new,:create]
  resources :quizzes
  resources :sections
  resources :users, except: [:index]

  # resources :teachers
  # resources :students, except: [:index]
  # resources :sections do
  #   resources :quizzes
  #   resources :students
  # end
  # get "/quizzes" => "quizzes#index", as: "quizzes"

end
