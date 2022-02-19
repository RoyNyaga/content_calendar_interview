# frozen_string_literal: true

class SocialNetwork < ApplicationRecord
  belongs_to :user
  has_many :publishing_targets, dependent: :destroy
  has_many :content_items, through: :publishing_targets
end
