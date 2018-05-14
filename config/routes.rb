Rails.application.routes.draw do
  root "purchase#index"

  get "/index" => "purchase#index"
  post "/upload" => "purchase#upload", as: :purchase_upload
  post "/remove" => "purchase#remove", as: :purchase_remove
end
