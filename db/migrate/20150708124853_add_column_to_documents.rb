class AddColumnToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :upload, :string
  end
end
