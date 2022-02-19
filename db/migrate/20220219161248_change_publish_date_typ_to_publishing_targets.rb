class ChangePublishDateTypToPublishingTargets < ActiveRecord::Migration[6.1]
  def change
    change_column :publishing_targets, :publish_date, :datetime
  end
end
