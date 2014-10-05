module ApplicationHelper

	def is_current(link, controller = nil)
    if controller.present?
      controller == controller_name ? "active" : ""
    else
		  current_page?(link) ? "active" : ""
    end
	end

end
