class Client < ApplicationRecord
  has_many :posts
  has_many :services

  belongs_to :user
  validates :fname, :lname, presence: true
  validates :fname, :lname, length: { minimum: 2 }

    mount_uploader :selfie, SelifieUploader

  def get_average_rating()
  	if current_client_jobs= Service.where(client_id: self.id).where.not(client_rating: nil)
  		current_client_jobs.average(:client_rating)
  	end
  end

  def get_posts_numbers()
  	  	all_client_post= Post.where(client_id: self.id).count
  end


end
