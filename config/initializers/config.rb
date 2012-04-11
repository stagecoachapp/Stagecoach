#load custom app config settigs

APP_CONFIG = YAML.load_file(Rails.root.join('config', 'config.yml'))[Rails.env]