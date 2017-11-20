class Service < ApplicationRecord
  belongs_to :teenager
  belongs_to :post
  before_create :set_client

  enum status: [:open, :beingInvited, :applied, :rejected, :enrolled, :finished, :confirmed]

  include Filterable

  scope :status, -> (status) { where status: status }
  scope :post, -> (post) { where post_id: post }


  def set_client
    self.client_id = self.post.client_id
  end



  def post_title
    post.title
  end


end