module SectionsHelper
	def logged_in?
		unless user_signed_in?
			redirect_to sections_path
		end
	end


	def student_leave #Student can't get access.Only teachers can.
		if current_user.class != Teacher
			redirect_to '/'
		end
    end

    def permission
    	

    	
    	if current_user.sections.include?(@section) == false
    			redirect_to section_confirm_path(@section)
    	end
    end
    	
    		    	

end



