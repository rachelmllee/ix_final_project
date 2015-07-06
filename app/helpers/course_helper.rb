module CourseHelper

	def can_edit?
		user_signed_in? && (current_user.admin? || current_user.tutor?)
	end

	def can_delete?
		user_signed_in? && current_user.admin?
	end

	def can_create?
		user_signed_in? && current_user.admin?
	end

end