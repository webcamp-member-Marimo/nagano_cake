class Public::CartItemsController < ApplicationController
  def index
    @cart_items = current_customer.cart_items
    @total_price = 0
  end

  def create
    @new_cart_item = CartItem.new(cart_item_params)
    @cart_item = CartItem.find_by(item_id: @new_cart_item.item_id, customer_id: current_customer.id)
    if @cart_item
      @cart_item.update(amount: @new_cart_item.amount.to_i + @cart_item.amount)
    else
      @new_cart_item.save
    end
      redirect_to cart_items_path
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :customer_id, :amount)
  end
end