ActiveAdmin.register Client do
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
   permitted = [:list, :of, :attributes, :on, :model,:home_address,:cell_phone,:selfie,:description,:home_phone]
   permitted << [:fnmae,:lname] if current_admin_user.role =='superadmin'
   permitted
 end
 actions :all, :except => [:destroy]

 index do
		column "Name" do |client|
			link_to "#{client.lname} #{client.fname}", admin_client_path(client) 
		end

		column "Email" do |client|
			client.get_client_email
		end
	    column "Cell Phone" do |client|
	    	client.cell_phone
	    end

	     column "Home Address" do |client|
	    	client.home_address
	    end

	actions defaults: false do |post|
    item "Show", admin_client_path(post)
    text_node "&nbsp".html_safe
    item "Edit", edit_admin_client_path(post) 
    text_node "&nbsp".html_safe
    item "Delete"
  end
end


show title: :client_name  do

    panel "Recent Posts" do
    	#paginated_collection(teenager.services.page(params[:page]).per_page_kaminari(5), download_links: false) do
    	paginated_collection(client.posts.paginate(:page => params[:page], :per_page => 15	), download_links: false) do
    	table_for(collection) do |post|
    	column "Post" do |post|
			link_to "#{post.title}", admin_post_path(post) 
		end
		
		column "People need" do |post|
			post.number_of_teenager_needed
		end
		column "Service Category" do |post|
			ServiceCategory.find(post.service_category_id).title

		end 
		column "Service Type" do |post|
			ServiceType.find(post.service_type_id).title
		end


	
		column "Pay" do |post|
			#status_tag(ervice.status)
			number_to_currency post.pay
		end
		column "Status" do |post|
			if post.hasPosition == 'open'
				status_tag post.hasPosition , :green
			elsif  post.hasPosition == 'close'
				status_tag post.hasPosition , :gray
			end
		end
		end

	end
    end

end

  sidebar "Basic Information", only: :show do
    attributes_table_for client do
    row("Name") {client.client_name }
    row ("Email") {client.user.email}

    row ("Address") {client.home_address}
      #row("Total Value") do
       # number_to_currency user.orders.complete.sum(:total_price)
      #end
    end
  end

   sidebar "Service Information", only: :show do
    attributes_table_for client do 
    row ("Rating") {"#{client.get_average_rating.round} out of 5"}
     row ("Totay Paid") {	number_to_currency client.get_total_paid}
     row("Total Jobs#") { "#{client.posts.count} Jobs" }
#
   # :fname, :lname, teenager.get_average_rating
end
  end






end
