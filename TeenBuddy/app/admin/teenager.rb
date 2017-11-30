ActiveAdmin.register Teenager do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
	  scope :all, :default => true

filter :birth_date
#ilter :user, :as => :check_boxes


	index do
		column "Name" do |teenager|
			link_to "#{teenager.lname} #{teenager.fname}", admin_teenager_path(teenager) 
		end
		column :postal_code
		column :birth_date

		column "Age" do |teenager|
			Teenager.get_age(teenager.birth_date)
			#teenager.get_average_rating
		end

		column 'Email Address', :user

	actions
end

end
