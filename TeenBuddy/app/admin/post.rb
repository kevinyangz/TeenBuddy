ActiveAdmin.register Post do
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

permit_params :list, :of, :attributes, :on, :model, :description, :pay, :number_of_teenager_needed, :work_address
	   scope :all, :default => true
	   scope :open do |posts|
	   		 #Post.where(:status => [:enrolled, :finished, :confirmed])
	   		 test= posts.all.select do |post|
	   		    (post.services.where(:status => [:enrolled, :finished, :confirmed]).count ) < post.number_of_teenager_needed
	   		 end
	   		 posts.where(id: test.map(&:id))
  	  end
  	  	   scope :close do |posts|
	   		 #Post.where(:status => [:enrolled, :finished, :confirmed])
	   		 test= posts.all.select do |post|
	   		    (post.services.where(:status => [:enrolled, :finished, :confirmed]).count ) >= post.number_of_teenager_needed
	   		 end
	   		 posts.where(id: test.map(&:id))
  	  end



	index  do

		column "Post Title" do |post|
			link_to "#{post.title}", admin_post_path(post) 
		end		
		column :description
    	column("pay")    {|post| number_to_currency post.pay }
		column :work_address
		column "Client Name" do |post|
			link_to "#{post.client.lname} #{post.client.fname}", admin_client_path(post.client) 
		end
		column "Status" do |post|
			if post.hasPosition == 'open'
				status_tag post.hasPosition , :green
			elsif  post.hasPosition == 'close'
				status_tag post.hasPosition , :gray
			end
		end

        
 
		#column "Age" do |teenager|
		#	Teenager.get_age(teenager.birth_date)
			#teenager.get_average_rating
		#nd
  if current_admin_user.role == 'admin'
  actions  defaults: false do |resource|
  #	destroy_admin_user_path
  item "Show", admin_post_path(resource)
  end
  elsif current_admin_user.role =='superadmin'
  actions defaults: false do |post|
    item "Show", admin_post_path(post)
    text_node "&nbsp".html_safe
    item "Edit", edit_admin_post_path(post) 
    text_node "&nbsp".html_safe
    item "Delete", admin_post_path(post), method: :delete
  end

  
  end 	 


end
#####################################################################################################
 show title: :title  do
 panel "Service Teenagers" do
    	#paginated_collection(teenager.services.page(params[:page]).per_page_kaminari(5), download_links: false) do
    	paginated_collection(post.services.paginate(:page => params[:page], :per_page => 15	), download_links: false) do
    	table_for(collection) do |service|
    	column "Post" do |service|
			link_to "#{service.id}", admin_service_path(service) 
		end
		column "Teenager Name" do |service|
		link_to "#{service.teenager.teenager_name}",  admin_teenager_path(service.teenager)		
		end

		column "Pay" do |service|
			#status_tag(ervice.status)
			number_to_currency service.post.pay
		end
			column "Status" do |service|
			if service.post.hasPosition == 'open'
				status_tag service.post.hasPosition , :green
			elsif  service.post.hasPosition == 'close'
				status_tag service.post.hasPosition , :gray
			end
		end
		column "Client Rating " do |service|
			#status_tag(ervice.status)
			 service.client_rating
		end
		column "Teenager Rating" do |service|
			#status_tag(ervice.status)
			service.teen_rating
		end
		column "Client Review" do |service|
			#status_tag(ervice.status)
			service.client_review
		end
		
		column "Teenager Review" do |service|
			#status_tag(ervice.status)
			service.teen_review
		end

	
		end

	end
    end
 end
################################################################################

end
