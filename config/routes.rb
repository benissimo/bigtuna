BigTuna::Application.routes.draw do
  if BigTuna.read_only?

    resources :projects, :only => [:index, :show] do
      member { get "feed" }
    end
    resources :builds, :only => [:show, :report] do
      member { get :report }
    end

  else

    resources :projects do
      member { get "build"; get "remove"; get "arrange"; get "feed"; get "duplicate" }
      match "/hooks/:name/configure", :to => "hooks#configure", :as => "config_hook"
    end
    resources :builds do
      member { get :report }
    end
    resources :step_lists
    resources :shared_variables

  end

  match "/hooks/build/:hook_name", :to => "hooks#autobuild"
  match "/hooks/build/github/:secure", :to => "hooks#github"
  match "/hooks/build/bitbucket/:secure", :to => "hooks#bitbucket"
  match "/hooks/build_from_ref_name", :to => "hooks#ref_name"
  root :to => "projects#index"
end
