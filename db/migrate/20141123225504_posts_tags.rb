class PostsTags < ActiveRecord::Migration
  def change
    create_table :posts_tags do |t|
      t.references :post, index: true
      t.references :tag, index: true
    end
  end
end
