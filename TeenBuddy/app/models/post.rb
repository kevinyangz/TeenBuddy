class Post < ApplicationRecord
  # database tables associations
  belongs_to :client
  belongs_to :service_category
  belongs_to :service_type
  has_many :post_applications
  has_many :services
  
  # getter and setter
  # validations
  validates :title, :description, :work_address, :pay, presence:true
  validates :number_of_teenager_needed, numericality:{greater_than:0}
  validates :number_of_teenager_needed, format:{with: /[0-9]+/}


  include Filterable

  scope :title, -> (title) { where title: title }



  # functions
  def applicable teenager

    if Service.where(:teenager_id => teenager.id, :post_id => self.id).any?
      'Enrolled, In progress'
    elsif PostApplication.where(:teenager_id => teenager.id, :post_id => self.id).any?
      'You have applied this job.'
    elsif self.status != 'open'
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
