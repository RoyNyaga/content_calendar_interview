# frozen_string_literal: true

class ContentItemsController < SecureController
  def index
    @content_items = current_user.content_items
    @publishing_targets = PublishingTarget.where(content_item_id: @content_items.pluck(:id))
  end

  # ContentItem.where("lower(title) like ?", "%content%")

  def show
    @content_item = ContentItem.find(params[:id])
    @publishing_targets = PublishingTarget.where(content_item_id: @content_item)
  end

  def search
    content_items = ContentItem.joins(:action_text_rich_text).where("lower(action_text_rich_texts.body) LIKE ? or lower(title) LIKE ?", "%#{params[:q].downcase}%", "%#{params[:q].downcase}%")
    @publishing_targets = PublishingTarget.where(content_item_id: content_items.uniq.pluck(:id))
  end

  def new
    @content_item = ContentItem.new
    @content_item.user = current_user
  end

  def create
    @content_item = ContentItem.new(content_item_params)
    @content_item.user = current_user

    if @content_item.save
      redirect_to content_items_path, notice: "#{@content_item.title} added"
    else
      render :new
    end
  end

  def edit
    @content_item = ContentItem.find(params[:id])
  end

  def update
    @content_item = ContentItem.find(params[:id])
    @content_item.assign_attributes(content_item_params)

    if @content_item.save
      redirect_to content_items_path, notice: "#{@content_item.title} updated"
    else
      render :edit
    end
  end

  def destroy
    @content_item = current_user.content_items.find(params[:id])
    @content_item.destroy

    redirect_to content_items_path, notice: "#{@content_item.title} deleted"
  end

  private

  def content_item_params
    params.require(:content_item).permit(:title, :body, social_network_ids: [])
  end
end
