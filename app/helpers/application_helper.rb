module ApplicationHelper
	def link_to_add_fields(name, f, association)
		new_object = f.object.send(association).klass.new
		id = new_object.object_id
		fields = f.fields_for(association, new_object, child_index: id) do |builder|
			render(association.to_s.singularize + "_fields", f: builder)
		end
		link_to(name, "#", class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
	end
	
	def link_to_chart(name)
		link_to(name, "#", class: "select_chart", data: {})
	end
	
	def voter_type_path
		if current_user.nil?
			@voter_type_path = 'static_pages/guest_vote'
		elsif current_user.dj?
			@voter_type_path = 'static_pages/dj_vote'
		elsif current_user.couple?
			@voter_type_path = 'static_pages/couple_vote'
		end
	end
	
	def chart_message
		if current_user.nil?
			@message = 'You like?'
		elsif current_user.dj?
			@message = 'Crowd reaction'
		elsif current_user.couple?
			@message = 'This cool?'
		end
	end
end