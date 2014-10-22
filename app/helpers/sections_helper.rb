module SectionsHelper

  def permission
    if current_user.sections.include?(@section) == false
    		redirect_to section_confirm_path(@section)
    end
  end

end



