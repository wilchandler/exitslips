module ApplicationHelper
	def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  # def link_to_add_fields(name, f, association, question_type = nil)
  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    # new_object.question_type = question_type if question_type #
    # debugger
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    # debugger
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end

  def current_user_id
    session["warden.user.user.key"][0][0]
  end

  def current_teacher
    Teacher.find_by(id: current_user_id)
  end

  def current_student
    Student.find_by(id: current_user_id)
  end

  def current_user
    User.find_by(id: current_user_id)
  end

  def current_user_is_teacher?
    !(current_teacher.nil?)
  end
end
