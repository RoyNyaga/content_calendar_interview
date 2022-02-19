# frozen_string_literal: true

class PublishingTarget < ApplicationRecord
  belongs_to :content_item
  belongs_to :social_network

  def start_time
    self.publish_date ##Where 'start' is a attribute of type 'Date' accessible through MyModel's relationship
  end
end
