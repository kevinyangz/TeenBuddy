class Post < ApplicationRecord
  # database tables associations
  belongs_to :client
  belongs_to :service_category
  belongs_to :service_type

  has_many :services
  
  # getter and setter
  # validations
  validates :title, :description, :work_address, :pay, presence:true
  validates :number_of_teenager_needed, numericality:{greater_than:0}
  validates :number_of_teenager_needed, format:{with: /[0-9]+/}
  validate :have_enough_money


  include Filterable

  scope :searched_keyword, -> (searched_keyword) { where('title LIKE ? or 
                                                          description LIKE ? or 
                                                          requirements LIKE ?',
                                                          "%#{searched_keyword}%", 
                                                          "%#{searched_keyword}%", 
                                                          "%#{searched_keyword}%") }

  scope :status, -> (status) { where('status = ?', "#{status}") }


  def hasPosition
    if self.number_of_teenager_needed > self.services.where(:status => [:enrolled, :finished, :confirmed]).count
      'open'
    else
      'close'
    end
  end

  def have_enough_money
    if self.client.available_credit < (self.pay * self.number_of_teenager_needed)
      errors.add(:client,"You do not have sufficient fund for your post, please make a deposit.")
    end
  end



  # functions
  def applicable teenager

    if !(teenager_service = Service.where(:teenager_id => teenager.id, :post_id => self.id).first()) || teenager_service.open?

      if self.hasPosition == 'open'
        'applicable'
      else
        'This Job has been closed.'
      end
    elsif teenager_service.beingInvited?
        'You have been invited for this job, please check the Offers.'
    elsif teenager_service.applied?
      'You have applied for this job'
    elsif teenager_service.enrolled?
      'In Progress'
    elsif teenager_service.finished?
      'You have finished this job'
    elsif teenager_service.confirmed?
      'Done'
    end

  end


end
