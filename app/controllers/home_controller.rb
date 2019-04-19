# frozen_string_literal: true

class HomeController < AuthenticatedController
  def index
    redirect_to controller: "variants", action: "index"
    @webhooks = ShopifyAPI::Webhook.find(:all)
  end
end
