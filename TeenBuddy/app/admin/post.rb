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
	  scope :all, :default => true
  #scope :available do |posts|
	#	posts.joins(:services).where(services.status => [:enrolled, :finished, :confirmed])
  #end
	 # scope("available") { |scope| scope.where("hasPosition > ?",100) }
	 # scope("available") { |scope| scope.joins(:services).where("services.teen_rating > ?",100) }
	 #'term in (?)', terms
	  scope("available") { |scope| scope.joins(:services).where('services.status IN (?)', [4,5,6]) }
	 	  # scope :available do |scope|
	 	   	#@scope.where(hasPosition)
	 	   			#scope.joins(:services).where('services.status IN (?)', [4,5,6])
					#a=scope.joins(:services).where('services.status IN (?)', [4,5,6]) 

 	  end
	# scope("available") { |scope| scope.joins(:services).where(:status => [:enrolled, :finished, :confirmed]) }

	  #self.services.where(:status => [:enrolled, :finished, :confirmed]).count
	  #scope :ind, -> { joins(:service).where("countries.name like %india%") }
	  #scope :available, -> { Post.joins(:services).where("services.teen_rating > ?",2) }
	   #scope :available do |posts|
     	#		 posts.joins(:services).where("pay > ?", 100)
  	  #end
  	  # scope :available do |posts|
      #			test= Post.joins(:services)
      #			 Post.joins(:services).select('services.teen_rating,posts.id').where("services.teen_rating > ?",3)
      #			 Post.joins(:services).where("services.teen_rating > ?",2)
  #end


	index do

		column :title
		column :description
		column :pay
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
