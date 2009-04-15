ActionController::Routing::Routes.draw do |map|

    map.signup '/signup', :controller => 'users', :action => 'new'
    map.login  '/login',  :controller => 'sessions', :action => 'new'
    map.logout '/logout', :controller => 'sessions', :action => 'destroy'
    map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate', :activation_code => nil


#  map.resources :fasta_files

# map.resource :taxon

#  map.resource :biodatabase
##
#  map.resource :seqfeature
#
#  map.resource :location
#
#  map.resource :bioentrie
#
#  map.resource :biosequence,:collection=>{:to_image=>:get}

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  
#    map.resources :biodatabases

   map.root :controller => "home"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
