class AddDetailsToUser < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :phone_no, :string
    add_column :users, :date_of_birth, :string
    add_column :users, :role, :string
  end
end
