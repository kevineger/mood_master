class RemovePostIdColumnFromTags < ActiveRecord::Migration
  def change
    remove_column :tags, :post_id
  end
end
