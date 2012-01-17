ActiveAdmin.register Changelog do

	form do |f|
		f.inputs 'Details' do
		  f.input :created_at
		  f.input :developer
		  f.input :description
		end
		f.buttons
	end

end
