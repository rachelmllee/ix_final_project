module DocumentHelper

	def can_edit_doc?
		user_signed_in? && (current_user.admin? || current_user.tutor?)
	end

	def can_delete_doc?
		user_signed_in? && current_user.admin? 
	end

	def can_create_doc?
		user_signed_in? && (current_user.admin? || current_user.tutor?)
	end

end