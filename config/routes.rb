Rails.application.routes.draw do
  resources :demo_praw_pdfs, only: :index
end
