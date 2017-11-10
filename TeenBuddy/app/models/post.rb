class Post < ApplicationRecord
  # database tables associations
  belongs_to :client
  #belongs_to :service
  has_many :post_applications
  has_many :services
  belongs_to :service_category
  belongs_to :service_type
  
  # action call backs
  #after_initialize :initialize_post_status
  after_initialize :close_post_status

  # getter and setter
  attr_accessor :status

  # validations
  validates :title, :description, :work_address, :pay, presence:true
  validates :number_of_teenager_needed, numericality:{greater_than:0}
  validates :number_of_teenager_needed, format:{with: /[0-9]+/}

  # functions
  # initialize the post status to open
  def initialize_post_status
  	self.status = "open"
  end

  def close_post_status
    self.status = "close"
  end

  def applicable teenager

    if Service.where(:teenager_id => teenager.id, :post_id => self.id).any?
      'Enrolled, In progress'
    elsif PostApplication.where(:teenager_id => teenager.id, :post_id => self.id).any?
      'You have applied this job.'
    elsif self.status != :open
      'This post has been closed.'
    elsif PostInvitation.where(:teenager_id => teenager.id, :post_id => self.id).any?
      'You have been invited for this job, please check the Invitations.'
    else
      'applicable'
    end

  end

  def self.search(description)
    if description
      where('description LIKE ? or title LIKE ? or requirements LIKE ?', "%#{description}%", "%#{description}%", "%#{description}%")
    else
      all
    end
  end

end
