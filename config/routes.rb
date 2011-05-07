Rails.application.routes.draw do  
  match "/visits/record.gif" => "control_center/visits#record", :as => "record_visit"
  match "/visits/js" => "control_center/visits#visit_recorder_js", :as => "visit_recorder_js"
  match '/gridfs/*path' => 'control_center/gridfs#serve', :as => "gridfs" unless Rails.env == 'production'
  
  scope :constraints => {:subdomain => "controlcenter"}, :module => "control_center", :as => "control_center"  do
    match "/statistics" => "main#statistics", :as => "statistics"
    resources :pages do
      member do
        post :upload_file
      end
      resources :grid_files
    end
    root :to => "main#statistics"
  end
end