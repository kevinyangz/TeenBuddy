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
 permit_params do
   permitted = [:list, :of, :attributes, :on, :model,:home_address,:postal_code]
   permitted << [:lname,:birth_date,:fname] if current_admin_user.role =='superadmin'
   permitted
 end


#permit_params :list, :of, :attributes, :on, :model, :description, :fname


scope :all, :default => true
filter :fname
filter :lname

#ilter :user, :as => :check_boxes



	index do
		column "Name" do |teenager|
			link_to "#{teenager.lname} #{teenager.fname}", admin_teenager_path(teenager) 
		end

		column "Email" do |teenager|
			teenager.get_teenager_email
		end
		column :postal_code	

		column "Age" do |teenager|
			Teenager.get_age(teenager.birth_date)
			#teenager.get_average_rating
		end

	actions
end

 show title: :teenager_name  do

    panel "Recent Services" do
    	#paginated_collection(teenager.services.page(params[:page]).per_page_kaminari(5), download_links: false) do
    	paginated_collection(teenager.services.paginate(:page => params[:page], :per_page => 15	).order('status DESC'), download_links: false) do
    	table_for(collection) do |service|
    	column "Jobs" do |service|
			link_to "#{service.post.title}", admin_post_path(service.post) 
		end
	
		column "Client" do |service|
			link_to "#{service.post.client.lname} #{service.post.client.fname}", admin_client_path(service.post.client) 
		end


		 column("Status") do |service|
			#status_tag(ervice.status)
			status_tag "#{service.status}", service.status_style_aa(service.status)

		end
		column "Pay" do |service|
			#status_tag(ervice.status)
			number_to_currency service.post.pay
		end
		end


    end


end




  end

  sidebar "Basic Information", only: :show do
    attributes_table_for teenager do
    row("Name") {teenager.teenager_name }
    row ("Email") {teenager.user.email}

    row ("Address") {teenager.home_address}
    row ("Postal Code"){teenager.postal_code}
      #row("Total Value") do
       # number_to_currency user.orders.complete.sum(:total_price)
      #end
    end
  end

   sidebar "Service Information", only: :show do
    attributes_table_for teenager do 
    row("Name") {teenager.teenager_name }
    row ("Rating") {"#{teenager.get_average_rating.round} out of 5"}
     row ("Totay Salary") {	number_to_currency teenager.get_total_paid}
     row("Services#") { "#{teenager.services.where(:status => [:finished]).count} Times" }
#
   # :fname, :lname, teenager.get_average_rating
end
  end





end
