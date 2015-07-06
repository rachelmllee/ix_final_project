class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title
      t.text :description
      t.string :length
      t.references :course, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
