class PostInvitation < ApplicationRecord
  belongs_to :post
  belongs_to :teenager
end
