class PostApplication < ApplicationRecord
  belongs_to :post
  belongs_to :teenager
  after_update :initialize_service
  include Filterable

  scope :status, -> (status) { where status: status }
  scope :post, -> (post) { where post_id: post }


  def initialize_service
    if self.status == 'Approved' || PostInvitation.where(teenager_id: self.teenager_id, post_id: self.post_id)
      new_service = Service.new(teenager_id: self.teenager_id, post_id: self.post_id, client_id: self.post.client_id)
      new_service.save
    end
  end

  def post_title
    post.title
  end
end
