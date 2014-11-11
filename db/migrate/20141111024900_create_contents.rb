class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.string :link
      t.references :post, index: true
      t.string :name

      t.timestamps
    end
  end
end
