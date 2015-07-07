module VideoHelper

	def can_edit_video?
		user_signed_in? && (current_user.admin? || current_user.tutor?)
	end

	def can_delete_video?
		user_signed_in? && current_user.admin?
	end

	def can_create_video?
		user_signed_in? && (current_user.admin? || current_user.tutor?)
	end

end