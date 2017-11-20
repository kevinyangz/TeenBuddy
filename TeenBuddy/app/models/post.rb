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


  include Filterable

  scope :searched_keyword, -> (searched_keyword) { where('title LIKE ? or 
                                                          description LIKE ? or 
                                                          requirements LIKE ?',
                                                          "%#{searched_keyword}%", 
                                                          "%#{searched_keyword}%", 
                                                          "%#{searched_keyword}%") }

  scope :status, -> (status) { where('status = ?', "#{status}") }





  # functions
  def applicable teenager

    if !(teenager_service = Service.where(:teenager_id => teenager.id, :post_id => self.id).first()) || teenager_service.open?
      'applicable'
    elsif teenager_service.beingInvited?
        'You have been invited for this job, please check the Invitations.'
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
