class VariantsController < AuthenticatedController
  before_action :set_variant, only: [:show, :edit, :update, :destroy]

  # GET /variants
  # GET /variants.json
  def index
    @variants = Variant.all
  end

  # GET /variants/1
  # GET /variants/1.json
  def show
  end

  # GET /variants/new
  def new
    @variant = Variant.new
  end

  # GET /variants/1/edit
  def edit
  end

  # POST /variants
  # POST /variants.json
  def create
    shop_domain = ShopifyAPI::Shop.current.domain
    @shop = Shop.find_by(shopify_domain: shop_domain)
    @variant = @shop.variants.new(variant_params)
    respond_to do |format|
      if @variant.save
        count = ShopifyAPI::Product.count
        page = 1
        @products = []
        while count > 0 do
          @products = ShopifyAPI::Product.find(:all, :params => {:page => page, :limit => 250})
          count = count - 250
          page = page + 1
        end
        @products.each do |product|
          options = product.options;
          variants_tags = [];
          options.each do |option|
            if option.name == @variant.name
              option.values.each do |value|
                variants_tags << (option.name.downcase + '-' + value.downcase)
              end 
            end
          end
          puts(variants_tags)
          product.update_attributes(:tags => (product.tags.split(",") + variants_tags).join(", "))
        end
        format.html { redirect_to @variant, notice: 'Variant was successfully created.' }
        format.json { render :show, status: :created, location: @variant }
      else
        format.html { render :new }
        format.json { render json: @variant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /variants/1
  # PATCH/PUT /variants/1.json
  def update
    respond_to do |format|
      if @variant.update(variant_params)
        format.html { redirect_to @variant, notice: 'Variant was successfully updated.' }
        format.json { render :show, status: :ok, location: @variant }
      else
        format.html { render :edit }
        format.json { render json: @variant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /variants/1
  # DELETE /variants/1.json
  def destroy
    @variant.destroy
    respond_to do |format|
      format.html { redirect_to variants_url, notice: 'Variant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_variant
      @variant = Variant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def variant_params
      params.require(:variant).permit(:name, :shop_id)
    end
end
