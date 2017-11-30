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

	index do

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
			status_tag(post.hasPosition)
		end


 
		#column "Age" do |teenager|
		#	Teenager.get_age(teenager.birth_date)
			#teenager.get_average_rating
		#nd


	actions


end
sidebar :help do
  "Need help? Email us at help@teenBudy.com"
end
sidebar :Teenager, if: proc{ current_user.teenager } do
  "Only for Teenager!"

end
sidebar :Client, if: proc{ current_user.client} do
  "Only for client!"
end
end
