class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.text :description
      t.string :category
      t.string :grade
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
