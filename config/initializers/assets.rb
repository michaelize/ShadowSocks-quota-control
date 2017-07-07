# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

Rails.application.config.assets.precompile += ["#{:main}.coffee", "#{:main}.js", "#{:main}.css", "#{:main}.scss"]
Rails.application.config.assets.precompile += ["#{:static}.coffee", "#{:static}.js", "#{:static}.css", "#{:static}.scss"]
Rails.application.config.assets.precompile += ["#{:users}.coffee", "#{:users}.js", "#{:users}.css", "#{:users}.scss"]

