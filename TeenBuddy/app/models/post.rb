class Post < ApplicationRecord
  # database tables associations
  belongs_to :client
  #belongs_to :service
  has_many :post_applications
  has_many :services
  belongs_to :service_category
  belongs_to :service_type
  
  # action call backs
  after_initialize :initialize_post_status

  # getter and setter
  attr_accessor :post_status

  enum post_status: [:open, :close]

  # validations
  validates :title, :description, :work_address, :pay, presence:true
  validates :number_of_teenager_needed, numericality:{greater_than:0}
  validates :number_of_teenager_needed, format:{with: /[0-9]+/}

  # functions
  # initialize the post status to decision_pending
  def initialize_post_status
  	self.post_status = :open
  end

  def self.search(description)
    if description
      where('description LIKE ? or title LIKE ? or requirements LIKE ?', "%#{description}%", "%#{description}%", "%#{description}%")
    else
      all
    end
  end

end
