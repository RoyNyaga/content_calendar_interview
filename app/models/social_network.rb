# frozen_string_literal: true

class SocialNetwork < ApplicationRecord
  belongs_to :user
  has_one :publishing_target, dependent: :destroy
  has_many :content_items, through: :publishing_targets
end
