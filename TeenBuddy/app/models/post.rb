class Post < ApplicationRecord
  #belongs_to :client
  #belongs_to :service
  has_many :JobApplications
  
  after_create :initialize_status

  enum post_status: [:decision_pending, :work_in_progress, :work_completed]

  validates :title, :description, :work_address, :pay, presence:true
  validates :number_of_teenager_needed, numericality:{greater_than:0}
  validates :number_of_teenager_needed, format:{with: /[0-9]+/}

  def initialize_status
  	self.post_status = :decision_pending
  end

end
