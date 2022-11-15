class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @total_price = 0
  end

  def os_update
    @order = Order.find(params[:id])
    @order.update(params_order)
    if @order.status == "checked"
      @orderitems = @order.order_items
      @order.order_items.each do |order_item|
        order_item.update(making_status: 1)
      end
    end
    redirect_to admin_order_path(@order.id)
  end

  def ms_update
    @orderitem = OrderItem.find(params[:order_item_id])
    @orderitem.update(params_order_item)
    if @orderitem.making_status == "producing"
      @orderitem.order.update(status: 2)
    end
    if @orderitem.order.order_items.count == @orderitem.order.order_items.where(making_status: "done").count
      @orderitem.order.update(status: 3)
    end
    redirect_to admin_order_path(params[:id])
  end

  private
  def params_order
    params.require(:order).permit(:status)
  end
  def params_order_item
    params.require(:order_item).permit(:making_status)
  end
end
