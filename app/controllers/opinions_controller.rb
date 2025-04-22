class OpinionsController < ApplicationController
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

  private

  def opinion_params
    params.require(:opinion).permit(:rating, :content)
  end
end
