class ItemsController < ApplicationController
  def create
    @list = List.find(params[:list_id])
    @item = @list.items.create(item_params)
    if @item.save
      respond_to do |format|
        format.html { redirect_to list_path(@list) }
        format.json { render json: @item }
      end
    else
      render "lists/show"
    end
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    redirect_to list_path(@item.list)
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    respond_to do |format|
      format.json { render json: @item }
      format.html { redirect_to list_path(@item.list) }
    end
  end

  private

  def item_params
    params.require(:item).permit(:description, :status)
  end
end
