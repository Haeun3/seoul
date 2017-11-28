class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.belongs_to :user
      t.belongs_to :info
      t.timestamps null: false
    end
  end
end
