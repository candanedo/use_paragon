# frozen_string_literal: true

module UseParagon
  # Engine for Rails to include and precompile vendor assets
  class Engine < ::Rails::Engine
    initializer "use_paragon.assets.precompile" do |app|
      app.config.assets.precompile += %w[useparagon/connect.js]
    end
  end
end
