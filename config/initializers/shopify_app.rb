ShopifyApp.configure do |config|
  config.application_name = "My Shopify App"
  config.api_key = "201efb8ed431bd78c6ce2d683148c130"
  config.secret = "15f647e122b2a970dfeee6a69b5ac922"
  config.old_secret = "<old_secret>"
  config.scope = "read_products" # Consult this page for more scope options:
                                 # https://help.shopify.com/en/api/getting-started/authentication/oauth/scopes
  config.embedded_app = true
  config.after_authenticate_job = false
  config.api_version = "2019-04"
  config.session_repository = Shop
end
