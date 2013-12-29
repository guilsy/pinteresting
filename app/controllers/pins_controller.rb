class PinsController < ApplicationController
  before_action :set_pin, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @pins = Pin.all
  end

  def show
  end

  def new
    @pin = current_user.pins.build
    @pic = @pin.pics.build
  end

  def edit
    @pic = @pin.pics.build
  end

  def create
    @pin = current_user.pins.build(pin_params)
    @pic = @pin.pics.build(pic_params)
      if @pin.save
        redirect_to @pin, notice: 'Пин был успешно создан.'
      else
        render action: 'new'
      end
  end  

  def update
      if @pin.update(pin_params)
        redirect_to @pin, notice: 'Пин был успешно обновлен.'
      else
        render action: 'edit' 
      end
  end

  def destroy
    @pin.destroy
    redirect_to pins_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pin
      @pin = Pin.find(params[:id])
    end

    def correct_user
      @pin = current_user.pins.find_by(id: params[:id])
      redirect_to pins_path, notice: "Вы не авторизированы редактировать этот Пин" if @pin.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pin_params
      params.require(:pin).permit(:description, :image, :address, :bedroom_number, :price)
    end

    def pic_params
      params.require(:pic).permit(:pin_id, :image)
    end
end
