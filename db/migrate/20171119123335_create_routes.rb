class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.integer :start
      t.integer :end
      t.float :time

      t.timestamps null: false
    end
  end
end
