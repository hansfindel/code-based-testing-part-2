module ApplicationHelper

	def is_current(link)
		current_page?(link) ? "active" : ""
	end

end
