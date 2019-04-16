ShopifyApp.configure do |config|
  config.application_name = "My Shopify App"
  config.api_key = "5269e26e780c35d2937da98aa95c98b3"
  config.secret = "aff688398247ac0bbd88c5c86d7c93b2"
  config.old_secret = "<old_secret>"
  config.scope = "read_products" # Consult this page for more scope options:
                                 # https://help.shopify.com/en/api/getting-started/authentication/oauth/scopes
  config.embedded_app = true
  config.after_authenticate_job = false
  config.api_version = "2019-04"
  config.session_repository = Shop
end
