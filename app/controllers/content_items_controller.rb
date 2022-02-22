# frozen_string_literal: true
class ContentItemsController < SecureController
  def index
    @content_items = current_user.content_items
    @publishing_targets = PublishingTarget.where(content_item_id: @content_items.pluck(:id))
    @initial_targets = @publishing_targets
  end

  def show
    @content_item = ContentItem.find(params[:id])
    @publishing_targets = PublishingTarget.where(content_item_id: @content_item)
  end

  def search
    content_items = ContentItem.joins(:action_text_rich_text).where("lower(action_text_rich_texts.body) LIKE ? or lower(title) LIKE ?", "%#{params[:q].downcase}%", "%#{params[:q].downcase}%")
    @publishing_targets = PublishingTarget.where(content_item_id: content_items.uniq.pluck(:id)).order(publish_date: :desc)
    @initial_targets = @publishing_targets
    if params[:start_date].nil?
      params[:start_date] = !@publishing_targets.empty? && !@publishing_targets.last.publish_date.nil? ? @publishing_targets.last.publish_date.strftime("%Y-%m-%d") : Time.now.strftime("%Y-%m-%d")
    end
    flash[:alert] = "#{@publishing_targets.count} Result(s) Found"
  end

  def filter
    @social_network = SocialNetwork.where("lower(description) LIKE ?", "%#{params[:social_network_desciption].downcase}%").first
    @initial_targets = PublishingTarget.where("id IN (?)", params[:target_ids].split(","))
    @publishing_targets = if @social_network
                            @initial_targets.where("social_network_id = ?", @social_network.id)
                          else
                            []
                          end
    params[:start_date] =  params[:start_date].empty? ? Time.now.strftime("%Y-%m-%d") : params[:start_date]
  end

  def new
    @content_item = ContentItem.new
    @content_item.user = current_user
  end

  def create
    @content_item = ContentItem.new(content_item_params)
    @social_network_ids_with_publish_dates = params[:content_item][:social_network_ids].dup
    clean_params_social_network_ids
    @content_item.user = current_user
    if @content_item.save
      PublishingTarget.bulk_publish_date_update(@content_item.id, params[:content_item][:social_network_ids] ,@social_network_ids_with_publish_dates)
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
    @social_network_ids_with_publish_dates = params[:content_item][:social_network_ids].dup
    clean_params_social_network_ids
    @content_item.assign_attributes(content_item_params)
    if @content_item.save
      PublishingTarget.bulk_publish_date_update(params[:id], params[:content_item][:social_network_ids] ,@social_network_ids_with_publish_dates)
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

  def clean_params_social_network_ids
    params[:content_item][:social_network_ids].each_with_index do |value,index|
      params[:content_item][:social_network_ids][index] = value.split(" ").first
    end
  end

  def content_item_params
    params.require(:content_item).permit(:title, :body, social_network_ids: [])
  end
end
