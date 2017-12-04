class Service < ApplicationRecord
  belongs_to :teenager
  belongs_to :post
  before_create :set_client
  validate :position_filled
  validate :service_exists
  after_update :set_transaction
   after_save :send_message

  enum status: [:open, :beingInvited, :applied, :rejected, :enrolled, :finished, :confirmed]

  include Filterable

  scope :status, -> (status) { where status: status }
  scope :post, -> (post) { where post_id: post }



  def set_client
    self.client_id = self.post.client_id
  end


def position_filled
  if self.post.hasPosition == 'close' && (self.status == :enrolled)
    errors.add(:post,"The Job has been filled with enough people.")
  end
end

  def set_transaction
    if self.confirmed?
      @post_transaction = Transaction.new(user: self.post.client.user, inout: true, comment: "Unhold (#{self.post.title}) to Pay Service ", amount: self.post.pay.to_i*100)
      @post_transaction.save
      @client_transaction = Transaction.new(user: self.post.client.user, inout: false, comment: "Pay for (#{self.post.title}) to (#{self.teenager.fname} #{self.teenager.lname})", amount: self.post.pay.to_i*100)
      @client_transaction.save
      @teen_transaction = Transaction.new(user: self.teenager.user, inout: true, comment: "Payment of (#{self.post.title}) from (#{self.post.client.fname} #{self.post.client.lname})", amount: self.post.pay.to_i*100)
      @teen_transaction.save
      self.post.credit = self.post.credit - self.post.pay.to_i * 100
      self.post.save
    end
  end


  def service_exists
    if my_service = Service.where(teenager_id: self.teenager_id, post_id: self.post_id).first
      if my_service.enrolled? || my_service.finished? || my_service.confirmed?
        if self.applied?
          errors.add(:post,"You already enrolled in this job")
        elsif self.beingInvited?
          errors.add(:post,"This teenager already enrolled in this job.")
        end
      else
        if self.applied?
          errors.add(:post,"The CLient already invited you for this job, please check your offers")
        elsif self.beingInvited?
          errors.add(:post,"The Teenager already applied for this job, please check the applications")
        end
      end

    end
  end


  def post_title
    self.post.title
  end


  def send_message
    if self.messageble
    case self.status.to_sym
      when :applied then
        self.teenager.user.send_message(self.post.client.user,  "#{self.applyMessage}","#{self.teenager.user.name} has applied your post #{self.post.title}")
      when :beingInvited then
        self.post.client.user.send_message(self.teenager.user,  "#{self.inviteMessage}","#{self.post.client.user.name} invites you to job #{self.post.title}")
      when :enrolled then
        self.teenager.user.send_message(self.post.client.user,  "#{self.applyMessage}", "#{self.teenager.user.name} has enrolled to your post #{self.post.title}")
        self.post.client.user.send_message(self.teenager.user,  "#{self.inviteMessage}", "you have enrolled to job #{self.post.title}")
      when :finished then
        self.teenager.user.send_message(self.post.client.user,  "#{self.applyMessage}","#{self.teenager.user.name} has finished job #{self.post.title}")
      when :confirmed then
        self.post.client.user.send_message(self.teenager.user, "#{self.inviteMessage}",  "#{self.post.client.user.name} has confirmed your work for #{self.post.title}")
      else puts 'did not enter any'

    end
      end
  end


end