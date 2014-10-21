Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get "sign_in", to: "sessions#new"
  end

  get "/sections/:section_id/quizzes/:id", to: "quizzes#results"
  get "/quizzes/:id/groups", to: "quizzes#groups", as: "quiz_groups"

  root to: 'home#index'

  resources :quizzes do
    resources :sittings, only: [:new, :create]
  end

  resources :sections
  resources :users, except: [:index]

  patch "/answers/:id", to: "answers#update"

  resources :standards, only: [:index], :defaults => { :format => 'json' }

  get "/quizzes/:id/finished_quiz" => "quizzes#finish", as: "quizzes_finish"
  get "/quizzes/:id/grade" => "quizzes#grade", as: "quiz_grade"

  post "/sections/add_section" => "sections#add_section", as: "add_section"

end
