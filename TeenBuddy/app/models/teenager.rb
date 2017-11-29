class Teenager < ApplicationRecord
  has_many :services, :dependent => :destroy
  belongs_to :user
  has_many :teenager_interests, :dependent => :destroy
  has_many :service_categories, through: :teenager_interests #Not sure about this relationship

  
  #Validate Canadian Postal Code. Need to use gem if more countries need to be checked.
  canadian_postal_code = /\A[ABCEGHJKLMNPRSTVXY]{1}\d{1}[A-Z]{1} *\d{1}[A-Z]{1}\d{1}\z/
 # validates :postal_code, format: { with: canadian_postal_code }
  validates :fname, presence: true
  validates :lname,presence: true
 # validates :home_address,presence: true
 # validates :cell_phone,presence: true
 # validates :birth_date, presence:true
  validate :age_requirement19, on: :create
  
  mount_uploader :selfie, SelifieUploader


  def self.get_age (birthdate)
     now = Time.now.utc.to_date
     age =now.year - birthdate.year 
     - ((now.month > birthdate.month ||
      (now.month == birthdate.month && 
        now.day >= birthdate.day)) ? 0 : 1)
     return age
  end
  #Age must be Greater than 19.
  def age_requirement19
  		if birth_date ==nil
  			return
  		elsif (birth_date >Date.today)
  			 errors.add(:birth_date, "Invaild Date,")
  		end	
 		 age= Teenager.get_age(birth_date)
  		if age>19
  			errors.add(:birth_date, "shoud less than 19")
  		end
  end

  def get_average_rating()
    #Filter Rating 
     if current_teenager_services= Service.where(teenager_id: self.id).where.not(teen_rating: nil)
         avg =current_teenager_services.average(:teen_rating)
         #current_teenager_services.each do |service|
         #sum += service.teen_rating
         #puts "++++#{service.teen_rating}++++"
         #end
        # current_teenager_services.teen_rating    
     end
     
  end

  def get_service_numbers()
    if current_teenager_services= Service.where(teenager_id: self.id).where.not(teen_rating: nil)
         count =current_teenager_services.count
    end
  end
  #
end