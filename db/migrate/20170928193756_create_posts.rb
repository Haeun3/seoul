class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :title #제목
      t.text :content #내용
      t.integer :user_id
      
      t.timestamps null: false
    end
  end
end
