class Service < ApplicationRecord
  belongs_to :teenager
  belongs_to :post
  before_create :set_client
  validate :position_filled
  validate :service_exists

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

  def service_exists
    if my_service = Service.where(teenager_id: self.teenager_id, post_id: self.post_id).first
      if my_service.enrolled? || my_service.finished? || my_service.confirmed?
        if self.applied?
          errors.add(:post,"You already enrolled in this job")
        elsif self.beingInvited?
          errors.add(:post,"This teenager already enrooled in this job.")
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
    post.title
  end


end