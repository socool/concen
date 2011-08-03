require "rails"

module ControlCenter
  class Engine < Rails::Engine
    rake_tasks do
      load "control_center/railties/setup.rake"
      load "control_center/railties/page.rake"
      load "control_center/railties/visit_statistic.rake"
    end

    # Add a load path for this specific Engine
    # config.autoload_paths << File.expand_path("../markdown.rb", __FILE__)
  end
end
