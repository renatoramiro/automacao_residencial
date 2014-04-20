# Run with: rackup private_pub.ru -s thin -E production
# Run curl: curl -X POST http://localhost:3000/services/:service_id/turn
require "bundler/setup"
require "yaml"
require "faye"
require "private_pub"

Faye::WebSocket.load_adapter('thin')

PrivatePub.load_config(File.expand_path("../config/private_pub.yml", __FILE__), ENV["RAILS_ENV"] || "development")
run PrivatePub.faye_app
