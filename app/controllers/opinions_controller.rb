class OpinionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_opinion, only: [:edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]
  def create
    @t_shirt = TShirt.find(params[:t_shirt_id])
    @opinion = @t_shirt.opinions.new(opinion_params)
    @opinion.user = current_user
    if @opinion.save
      redirect_to t_shirt_path(@t_shirt)
    else
      render 't_shirts/show'
    end
  end

  def destroy
    t_shirt = @opinion.t_shirt
    @opinion.destroy
    redirect_to t_shirt_path(t_shirt)
  end

  def edit
    @t_shirt = @opinion.t_shirt
  end

  def update
    if @opinion.update(opinion_params)
      redirect_to t_shirt_path(@opinion.t_shirt)
    else
      render edit_t_shirt_opinion_path(t_shirt)
    end
  end

  private

  def opinion_params
    params.require(:opinion).permit(:rating, :content)
  end

  def set_opinion
    @opinion = Opinion.find(params[:id])
  end

  def authorize_user!
    unless @opinion.user == current_user
      redirect_to t_shirt_path(@opinion.t_shirt)
    end
  end
end
