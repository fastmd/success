# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

Rails.application.config.assets.precompile += %w( vendor/modernizr.js )
Rails.application.config.assets.precompile += %w( bootstrap.min.js )
Rails.application.config.assets.precompile += %w( raphael.js )
Rails.application.config.assets.precompile += %w( morris.min.js )
Rails.application.config.assets.precompile += %w( morris.css )
Rails.application.config.assets.precompile += %w( datatables.min.js )
Rails.application.config.assets.precompile += %w( datatables.min.css )
Rails.application.config.assets.precompile += %w( jquery.dataTables.min.js )
Rails.application.config.assets.precompile += %w( jquery.dataTables.min.css )
Rails.application.config.assets.precompile += %w( dataTables.bootstrap.min.js )
Rails.application.config.assets.precompile += %w( dataTables.bootstrap.min.css )
Rails.application.config.assets.precompile += %w( dataTables.buttons.min.js )
Rails.application.config.assets.precompile += %w( buttons.bootstrap.min.js )
Rails.application.config.assets.precompile += %w( buttons.print.min.js )
Rails.application.config.assets.precompile += %w( buttons.bootstrap.min.css )
Rails.application.config.assets.precompile += %w( buttons.dataTables.min.css )
Rails.application.config.assets.precompile += %w( common.css )
Rails.application.config.assets.precompile += %w( mixins.css )

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
