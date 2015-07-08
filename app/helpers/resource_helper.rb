module ResourceHelper

	def can_edit_resource?
		user_signed_in? && (current_user.admin? || current_user.tutor?)
	end

	def can_delete_resource?
		user_signed_in? && current_user.admin?
	end

	def can_create_resource?
		user_signed_in? && (current_user.admin? || current_user.tutor?)
	end

	def embed_video(youtube_url)
	    youtube_id = youtube_url.split("=").last
	    content_tag(:iframe, nil, src: "//www.youtube.com/embed/#{youtube_id}")
	end

end