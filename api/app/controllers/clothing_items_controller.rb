class ClothingItemsController < ApplicationController
  before_action :set_item, only: %i[show update destroy]

  def index
    render json: ClothingItem.order(id: :desc).limit(100)
  end

  def show
    render json: @item
  end

  def create
    @item = ClothingItem.new(item_params)
    if @item.save
      render json: @item, status: :created
    else
      render json: { errors: @item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @item.update(item_params)
      render json: @item
    else
      render json: { errors: @item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    head :no_content
  end

  private

  def set_item
    @item = ClothingItem.find(params[:id])
  end

  def item_params
    params.permit(
      :user_id, :category, :color_primary_name, :color_secondary_name,
      :color_primary_hex, :color_secondary_hex, :notes, :image_url,
      :hue, :saturation, :lightness
    )
  end
end
