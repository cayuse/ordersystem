ActionController::Routing::Routes.draw do |map|
  map.resources :worksheets

  map.resources :companies

  map.resources :bidnames

  map.resources :foodvendors

  map.resources :nutritionals

  map.connect 'storelocs/reorder', :controller => "storelocs", :action => "reorder"
  map.connect 'storelocs/setup', :controller => "storelocs", :action => "setup"
  map.resources :storelocs

  map.resources :track_calendars


  map.connect 'reports/site_confirmations', :controller => "reports", :action => "site_confirmations"
  map.connect 'reports/week_totals/:id.:format', :controller => "reports", :action => "weeks_totals"
  map.resources :reports

  map.resources :monthlyinvitems

  map.resources :monthlyinvs

  map.start 'monthlyinvreqs/start', :controller => "monthlyinvreqs", :action => "start"
  map.resources :monthlyinvreqs


  map.resources :weeklydfcorders

  map.monthlyindex 'weeklyorderreqs/monthlyindex', :controller => "weeklyorderreqs", :action => "monthlyindex"
  map.start 'weeklyorderreqs/start', :controller => "weeklyorderreqs", :action => "start"
  map.resources :weeklyorderreqs

  map.resources :usages

  map.resources :weeks

  map.resources :itemtypes

  map.connect 'items/reorder', :controller => "items", :action => "reorder"
  map.resources :items

  map.resources :tracks

  map.resources :sitetypes

  map.resources :sites

  map.connect 'setting/create', :controller => "settings", :action => "update"
  map.connect 'setting/edit', :controller => "settings", :action => "edit"

  map.connect 'students/intersession' , :controller=> "students", :action => "intersession"

  map.resource :setting

  map.resources :students


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

  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  #map.connect ':controller/:action/:id.:format'
end
