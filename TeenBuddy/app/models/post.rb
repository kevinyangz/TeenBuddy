class Post < ApplicationRecord
  # database tables associations
  belongs_to :client
  belongs_to :service_category
  belongs_to :service_type

  has_many :services, :dependent => :delete_all
  
  # getter and setter
  # validations
  validates :title, :description, :work_address, :number_of_teenager_needed, :pay, presence:true
  validates :number_of_teenager_needed, numericality:{greater_than:0}
  validates :pay, numericality:{greater_than:0}
  validates :number_of_teenager_needed, format:{with: /[0-9]+/}
  validate :have_enough_money, :on => :create
  after_create :set_transaction
  after_destroy :get_back_money
  after_save :set_tag
  acts_as_taggable
  include Filterable

  scope :searched_keyword, -> (searched_keyword) { where('lower(title) LIKE ? or 
                                                          lower(description) LIKE ? or 
                                                          lower(requirements) LIKE ?',
                                                          "%#{searched_keyword.downcase}%", 
                                                          "%#{searched_keyword.downcase}%", 
                                                          "%#{searched_keyword.downcase}%") }

  scope :address, -> (address) {where('lower(work_address) LIKE ?', "%#{address.downcase}%")}

  scope :category_id, -> (category_id) {where('service_category_id = ?', "#{category_id}")}

  scope :type_id, -> (type_id) {where('service_type_id = ?', "#{type_id}")}

  scope :status , ->(status)  {
    test= Post.all.select do |post|
    post.hasPosition == status
      #(post.services.where(:status => [:enrolled, :finished, :confirmed]).count ) >= post.number_of_teenager_needed
    end
    Post.where(id: test.map(&:id))
  }

  def hasPosition
    if self.number_of_teenager_needed > self.services.where(:status => [:enrolled, :finished, :confirmed]).count
      'open'
    else
      'close'
    end
  end

  def have_enough_money
    if self.client.user.balance < (self.pay.to_i * self.number_of_teenager_needed.to_i * 100)
      errors.add(:client,"You do not have sufficient fund for your post, please make a deposit.")
    end
  end
  def set_transaction
    self.credit = self.pay.to_i * self.number_of_teenager_needed * 100
    self.save
    @transaction = Transaction.new(user: self.client.user, inout: false, comment: "Hold for job (#{self.title})", amount: self.credit)
    @transaction.save
  end
  def get_back_money
    @transaction = Transaction.new(user: self.client.user, inout: true, comment: "Unhold money from (#{self.title})", amount: self.credit)
    @transaction.save
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
  def set_tag
    self.tag_list.add(self.service_category.title)
  end


end
