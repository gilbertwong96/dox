import Config

# Dox configuration
# Plugins are auto-loaded by Dox.Application

# Import environment specific config
import_config "#{config_env()}.exs"
