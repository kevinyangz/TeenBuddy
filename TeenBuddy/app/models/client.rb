class Client < ApplicationRecord
  has_many :posts, :dependent => :delete_all
  has_many :services, :dependent => :delete_all

  belongs_to :user, :dependent => :destroy
  validates :fname, :lname, presence: true
  validates :fname, :lname, length: { minimum: 2 }

    mount_uploader :selfie, SelifieUploader

  def get_average_rating()
  	if current_client_jobs= Service.where(client_id: self.id).where.not(client_rating: nil)
  		current_client_jobs.average(:client_rating)
  	end
  end

  def get_service_counts()
    if current_client_jobs= Service.where(client_id: self.id).where.not(client_rating: nil)
        current_client_jobs.count
    end
  end


end
