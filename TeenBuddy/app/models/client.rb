class Client < ApplicationRecord
  has_many :posts, :dependent => :delete_all

  belongs_to :user
  validates :fname, :lname, presence: true
  validates :fname, :lname, length: { minimum: 2 }
  validates :cell_phone, presence: true, on: :update
  validates :home_address, presence: true, on: :update

  include Filterable

  scope :searched_keyword, -> (searched_keyword) { where('lower(fname) LIKE ? or 
                                                          lower(lname) LIKE ?',
                                                          "%#{searched_keyword.downcase}%", 
                                                          "%#{searched_keyword.downcase}%") }

  scope :address, -> (address) {where('lower(home_address) LIKE ?', "%#{address.downcase}%")}


  mount_uploader :selfie, SelifieUploader

  def get_average_rating()
  	if current_client_jobs= Service.where(client_id: self.id).where.not(client_rating: nil)
  		current_client_jobs.average(:client_rating).to_i
  	end
  end



  def get_total_paid()
    sum =0
     Service.where(client_id: self.id, :status => [:finished]).all.each do |service|
      sum = sum+ service.post.pay.to_i
     end
     sum
  end

    def get_total_post_paid()
    sum =0
     self.posts.all.each do |post|
      sum = sum+ post.pay.to_i
     end
     sum
  end

  def get_service_counts()
    if current_client_jobs= Service.where(client_id: self.id).where.not(client_rating: nil)
        current_client_jobs.count
    end
  end

   def get_total_post_counts()
    if current_client_jobs= Post.where(client_id: self.id)
        current_client_jobs.count
    end
  end

  def client_name()
    "#{fname} #{lname}"
  end
  
  def get_client_email()
         self.user.email
  end

end
