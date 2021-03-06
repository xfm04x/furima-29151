class ItemsController < ApplicationController
  before_action :move_to_new, except: [:index, :create, :show, :search]
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if@item.update(item_params)
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    if @item.destroy
      redirect_to items_path
    else
      render action: :show
    end
  end

  def search
    @items = Item.search(params[:keyword])
  end

  private

  def move_to_new
    redirect_to new_user_session_path unless user_signed_in?
  end

  def item_params
    params.require(:item).permit(:name, :description, :postage_id, :price, :category_id, :sipping_day_id, :condition_id, :prefecture_id, :image, :sold).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
