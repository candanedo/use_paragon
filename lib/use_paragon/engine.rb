module UseParagon
  class Engine < ::Rails::Engine
    initializer "use_paragon.assets.precompile" do |app|
      app.config.assets.precompile += %w( useparagon/connect.js )
    end
  end
end
