module ApplicationHelper

	def is_robots(controller)
		controller == "robots" ? "active" : ""
	end

	def is_weapons(controller)
		controller == "weapons" ? "active" : ""
	end

	def is_root(link)
		current_page?(link) ? "active" : ""
	end

end
