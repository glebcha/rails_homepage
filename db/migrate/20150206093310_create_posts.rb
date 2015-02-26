class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :name
      t.text :body
      t.integer :status, default: 0
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
