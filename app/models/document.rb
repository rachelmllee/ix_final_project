class Document < ActiveRecord::Base
  belongs_to :course


   has_attached_file :upload
  validates_attachment :upload, :content_type => {:content_type => %w(image/jpeg image/jpg image/png application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document)}
end
