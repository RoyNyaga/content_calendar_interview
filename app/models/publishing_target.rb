# frozen_string_literal: true

class PublishingTarget < ApplicationRecord
  belongs_to :content_item
  belongs_to :social_network

  def start_time
    self.publish_date ##Where 'start' is a attribute of type 'Date' accessible through MyModel's relationship
  end

  def self.bulk_publish_date_update(content_item_id, social_network_ids, social_network_ids_with_publish_dates)
    publishing_targets = PublishingTarget.where(content_item_id: content_item_id, social_network_id: social_network_ids)
    social_network_ids_with_publish_dates.each do |id_publish_date|
      target = publishing_targets.select { |target| target.social_network_id == id_publish_date.split(" ").first.to_i }.first
      target.update(publish_date: id_publish_date.split(" ").last) if id_publish_date.split(" ").size == 2
    end
  end
end
