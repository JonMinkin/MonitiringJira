Rails.application.routes.draw do
  get 'users/index'
  get 'users/show'
  get 'users/edit'
  get 'users/destroy'
  get 'projects/show'   
  get 'projects/index', as: 'user_root'
  get 'errors/error_404'
  devise_for :users
  resources :tasks
  resources :users
  resources :roles
  resources :projects do
    get :download_xlsx, on: :member, :defaults => { :format => 'xlsx' }
    get :index
  end
  root 'welcome#index'
  get '*unmatched_route', :to => 'errors#error_404'
end
