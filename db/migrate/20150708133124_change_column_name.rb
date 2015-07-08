class ChangeColumnName < ActiveRecord::Migration
  def change  	
    rename_column :documents, :file_file_name, :upload_file_name
    rename_column :documents, :file_content_type, :upload_content_type
    rename_column :documents, :file_file_size, :upload_file_size
    rename_column :documents, :file_updated_at, :upload_updated_at
  end
end
