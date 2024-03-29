Rails.application.routes.draw do
  devise_for :admin,skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  scope module: :public do
    root to: "homes#top"
    get 'about' => 'homes#about'
    get 'customers/my_page' => 'customers#show'
    get 'customers/information/edit' => 'customers#edit'
    patch 'customers/information' => 'customers#update'
    get 'customers/unsubscribe' => 'customers#unsubscribe'
    patch 'customers/withdrawal' => 'customers#withdrawal'
    resources :items, only:[:show, :index]
    delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
    resources :cart_items, only:[:index, :update, :destroy, :create]
    post 'orders/check' => 'orders#check'
    get 'orders/complete' => 'orders#complete'
    resources :orders, only:[:new, :create, :index, :show]
    resources :delivery_addresses, only:[:index, :edit, :create, :update, :destroy]
  end

  namespace :admin do
    root to: "homes#top"
    resources :items, only:[:index, :new, :create, :show, :edit, :update]
    resources :genres, only:[:index, :create, :edit, :update]
    get 'customers/:id/o_index' => "customers#o_index"
    resources :customers, only:[:index, :show, :edit, :update]
    patch 'orders/:id' => 'orders#os_update', as: :admin_os_update
    patch 'orders/:id/order_items/:order_item_id' => 'orders#ms_update', as: :admin_ms_update
    resources :orders, only:[:show]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
