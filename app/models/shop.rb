class Shop < ActiveRecord::Base
  include ShopifyApp::SessionStorage
  has_many :variants
  def api_version
    ShopifyApp.configuration.api_version
  end
end
