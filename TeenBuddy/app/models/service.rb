class Service < ApplicationRecord
  belongs_to :teenager
  belongs_to :post
  after_save :set_post_status
  after_destroy :set_post_status


  def set_post_status
    my_post = Post.find(self.post_id)
    if my_post.services.count >= my_post.number_of_teenager_needed
      my_post.post_status = :close
    else
      my_post.post_status = :open
    end
    my_post.save
  end
end