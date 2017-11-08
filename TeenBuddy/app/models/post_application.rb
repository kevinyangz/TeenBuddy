class PostApplication < ApplicationRecord
  belongs_to :post
  belongs_to :teenager
  after_update :initialize_service

  def initialize_service


    if self.status == 'Approved'
      new_service = Service.new
      new_service.teenager_id = self.teenager_id
      new_service.post_id = self.post_id
      new_service.save

      my_post = self.post

      if Service.where(post_id: self.post_id).count >= my_post.number_of_teenager_needed
        my_post.status 'close'
        my_post.save
      end
    end
  end
end
