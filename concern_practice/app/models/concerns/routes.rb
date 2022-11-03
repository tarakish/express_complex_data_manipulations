Rails.application.routes.draw do
  concern :cancelable do |options|
    resource :cancellation, options.merge(only: :create)
  end

  concern :confirmable do
    post "confirm", on: :collection
  end

  resources :orders, concerns: :confirmable, except: %i[edit update destroy] do
    concerns :cancelable, module: "orders"
  end
end