Rails.application.routes.draw do
  get '/', to: "requests#index"
  match "*path", to: "requests#index", via: :all
end
