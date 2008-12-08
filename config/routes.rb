ActionController::Routing::Routes.draw do |map|
  
  map.resources :crawlers, :active_scaffold => true,
    :member => {
      :crawl => :put,
      :clear_variants => :put
      }
  
  
  variants_interpreter_paths = {      
      :review_next => :get
    }  
  variant_interpreter_paths = {
      :review => :get,
      :skip_as_incorrect => :post
  }
  
  map.resources :locality_variants, :active_scaffold => true,
    :collection => variants_interpreter_paths,
    :member => variant_interpreter_paths
  
  map.resources :venue_variants, :active_scaffold => true,
    :collection => variants_interpreter_paths,
    :member => variant_interpreter_paths
  
  map.resources :event_variants, :active_scaffold => true,
    :collection => variants_interpreter_paths,
    :member => variant_interpreter_paths
  
  
  common_for_all_clean = {
      :create_from_variant => :post     
    }    
  map.resources :localities, :active_scaffold => true,
    :collection => common_for_all_clean,
    :member => {:review => :get,  :update_from_review => :put}
  
  map.resources :venues, :active_scaffold => true,
    :collection => common_for_all_clean,
    :member => {:review => :get,  :update_from_review => :put}
  
  map.resources :events, :active_scaffold => true,
    :collection => common_for_all_clean,
    :member => {:review => :get,  :update_from_review => :put}
  
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "dashboard", :action => 'overview'

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
