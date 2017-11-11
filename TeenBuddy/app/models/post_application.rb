class PostApplication < ApplicationRecord
  belongs_to :post
  belongs_to :teenager
  after_update :initialize_service

  def initialize_service
    if self.status == 'Approved'
      new_service = Service.new(teenager_id: self.teenager_id, post_id: self.post_id, client_id: self.post.client_id)
      new_service.save
    end
  end
end
