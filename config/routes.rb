Rails.application.routes.draw do
  resources :photos
  get '/upload_photos' => 'photos#upload_photos', as: :upload_photos
  post '/upload' => 'photos#upload', as: :upload
  root to: "photos#index"
end
