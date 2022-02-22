class PublishingTargetsController < ApplicationController
  before_action :set_publishing_target, only: [:edit, :update]

  def edit
  end

  def update
    if @publishing_target.update(publishing_target_params)
      redirect_to content_item_path(@publishing_target.content_item), notice: "Publish date was successfully updated"
    else
      render "edit"
    end
  end

  private

  def set_publishing_target
    @publishing_target = PublishingTarget.find_by(id: params[:id])
  end

  def publishing_target_params
    params.require(:publishing_target).permit(:publish_date)
  end
end
