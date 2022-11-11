class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def check
    @cart_items = current_customer.cart_items
    @total_price = 0
    @order = Order.new(order_params)
    @order.shipping_cost = 800
    if params[:order][:select_address] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:select_address] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    end
  end

  def create
    @order = Order.new(order_params)
    @order.save
    current_customer.cart_items.each do |cart_item|
      @order_item = OrderItem.new
      @order_item.order_id = @order.id
      @order_item.item_id = cart_item.item.id
      @order_item.amount = cart_item.amount
      @order_item.price = cart_item.item.tax_price
      @order_item.save
    end
    current_customer.cart_items.destroy_all
    redirect_to orders_complete_path
  end

  def complete
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @total_price = 0
  end

  private
  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :total_payment, :shipping_cost, :customer_id)
  end
end