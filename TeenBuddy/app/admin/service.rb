ActiveAdmin.register Service do
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
permit_params do
   permitted = [:list, :of, :attributes, :on, :model ,:status]
   permitted << [:client_review,:client_rating,:teen_review ,:teen_rating] if current_admin_user.role =='superadmin'
   permitted
 end



    scope :all, :default => true

	scope :finished do |services|

	   services.where(:status => [:finished])
	   		
  	  end
  	scope :confirmed do |services|
  			   		 services.where(:status => [:confirmed])

	   		
  	  end
  	   	scope :enrolled do |services|
  	   			   		 services.where(:status => [:enrolled])

  	  end
  	 scope :beingInvited do |services|
  	 		   		 services.where(:status => [:beingInvited])

  	  end

  	  	index do

  	  	column "Id" do |service|
  	  	   link_to "#{service.id}", admin_service_path(service)
  	  	end

		column "Post" do |service|
			link_to "#{service.post.title}", admin_post_path(service.post) 
		end
		column "Teenager" do |service|
			link_to "#{service.teenager.lname} #{service.teenager.fname}", admin_teenager_path(service.teenager) 
		end		
		column "Client" do |service|
			link_to "#{service.post.client.lname} #{service.post.client.fname}", admin_client_path(service.post.client) 
		end
		 column("Status", sortable: :status) do |service|
			status_tag service.status, service.status_style_aa(service.status)
		end

		 #column("Date", sortable: :checked_out_at) do |order|
         # pretty_format(order.checked_out_at)
        #nd

 
		#column "Age" do |teenager|
		#	Teenager.get_age(teenager.birth_date)
			#teenager.get_average_rating
		#nd


	actions


end









    



end
