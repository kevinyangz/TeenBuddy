
class Teenager < ApplicationRecord
  has_many :services, :dependent => :delete_all
  belongs_to :user
  has_many :teenager_interests, :dependent => :delete_all
  has_many :service_categories, through: :teenager_interests #Not sure about this relationship
  after_save :store_interest_to_tag

  acts_as_taggable

  #Validate Canadian Postal Code. Need to use gem if more countries need to be checked.
  canadian_postal_code = /\A[ABCEGHJKLMNPRSTVXY]{1}\d{1}[A-Z]{1} *\d{1}[A-Z]{1}\d{1}\z/
 # validates :postal_code, format: { with: canadian_postal_code }
  validates :fname, presence: true
  validates :lname,presence: true
  validates :birth_date, presence: true
  validates :home_address,presence: true, on: :update
  validates :cell_phone,presence: true, on: :update
  validate :age_requirement19, on: :create
  
  mount_uploader :selfie, SelifieUploader
  
  include Filterable

  scope :service_category_id , ->(service_category_id)  {
    current_teenager_interest=TeenagerInterest.where(:service_category_id =>service_category_id)
    Teenager.where(id:current_teenager_interest.select(:teenager_id))
  }

  scope :searched_keyword, -> (searched_keyword) { where('lower(fname) LIKE ? or 
                                                          lower(lname) LIKE ?',
                                                          "%#{searched_keyword.downcase}%", 
                                                          "%#{searched_keyword.downcase}%") }

  scope :address, -> (address) {
    where('lower(home_address) LIKE ?', "%#{address.downcase}%")}

  scope :minimum_review, -> {
    test= Teenager.all.select do |teenager|
    teenager.get_service_numbers > minimum_review_numbers
      #(post.services.where(:status => [:enrolled, :finished, :confirmed]).count ) >= post.number_of_teenager_needed
    end
    Teenager.where(id: test.map(&:id))
  }


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
         avg =current_teenager_services.average(:teen_rating).to_f.round(2)
     end
  end

  def get_average_rating_round()
    #Filter Rating 
     if current_teenager_services= Service.where(teenager_id: self.id).where.not(teen_rating: nil)
         avg =current_teenager_services.average(:teen_rating).to_f.round(1)
     end
  end

  def get_total_paid()
     sum =0
     self.services.where(:status => [:finished]).all.each do |service|
      sum = sum+ service.post.pay.to_i
     end
     sum
  end

  def get_all_service_numbers
      self.services.where(:status => [:finished]).count.to_i

  end

  def teenager_name()
    "#{fname} #{lname}"
  end

  def get_service_numbers()
    if current_teenager_services= Service.where(teenager_id: self.id).where.not(teen_rating: nil)
         count =current_teenager_services.count.to_i
    end
  end
  
  def self.minimum_review_numbers()
    2
  end

  def get_teenager_email()
     self.user.email
  end

  
  def store_interest_to_tag
    self.teenager_interests.each do |interest|
      self.tag_list.add(interest.service_category.title)
    end
  end
  #
end