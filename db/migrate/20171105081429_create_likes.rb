class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
       #like 모델은 user도 info도 부모로 갖는다
      t.belongs_to :user
      t.belongs_to :info
      t.timestamps null: false
    end
  end
end
