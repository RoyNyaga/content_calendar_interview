class AddPublishDateToPublishingTarget < ActiveRecord::Migration[6.1]
  def change
    add_column :publishing_targets, :publish_date, :date
  end
end
