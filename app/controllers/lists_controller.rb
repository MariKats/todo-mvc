class ListsController < ApplicationController
  before_action :authentication_required

  def index
    @lists = current_user.lists
    @list = List.new
  end

  def show
    @list = List.find(params[:id])
    @item = Item.new
  end

  def create
    @list = List.new(list_params)
    @list.user = current_user
    if @list.save
      redirect_to list_path(@list)
    else
      @lists = List.all
      render :index
    end
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy
    redirect_to lists_path
  end

  private

  def list_params
    params.require(:list).permit(:name, :user_id)
  end
end
