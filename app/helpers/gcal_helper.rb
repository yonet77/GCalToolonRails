module GcalHelper

	def admin_link
		return "" if current_user.login != "admin"
		
		return link_to("ADMIN画面", :controller=>:admin, :action=>:index)
	end
	
end
