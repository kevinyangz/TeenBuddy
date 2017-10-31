class Teenager < ApplicationRecord
  has_many :services
  has_many :post_applications
  belongs_to :user

  has_many :teenager_interests
  has_many :service_categories, through: :teenager_interests #Not sure about this relationship

  
  #Validate Canadian Postal Code. Need to use gem if more countries need to be checked.
  canadian_postal_code = /\A[ABCEGHJKLMNPRSTVXY]{1}\d{1}[A-Z]{1} *\d{1}[A-Z]{1}\d{1}\z/
  validates :postal_code, format: { with: canadian_postal_code }
  validates :fname, presence: true
  validates :lname,presence: true
  validates :home_address,presence: true
  validates :cell_phone,presence: true
  validates :birth_date, presence:true
  validate :age_requirement19, on: :create
  #Age must be Greater than 19.
  def age_requirement19
  		if birth_date ==nil
  			return
  		elsif (birth_date >Date.today)
  			 errors.add(:birth_date, "Invaild Date,")
  		end	
  		now = Time.now.utc.to_date
 		 age=now.year - birth_date.year 
 		 - ((now.month > birth_date.month ||
 		 	(now.month == birth_date.month && 
 		 		now.day >= birth_date.day)) ? 0 : 1)
  		if age>19
  			errors.add(:birth_date, "shoud less than 19")
  		end
  end

  #
end