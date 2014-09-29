module ApplicationHelper

	def is_current(regx)
		if regx != '/' and regx != '/welcome/index'
			request.original_url.include?(regx) ? "active" : ""
		else
			(current_page?(regx) or current_page?('/welcome/index')) ? "active" : ""
		end
	end

end
