class Service < ApplicationRecord
  belongs_to :teenager
  belongs_to :post

  enum status: [:open, :beingInvited, :applied, :rejected, :enrolled, :finished, :confirmed]

  include Filterable

  scope :status, -> (status) { where status: status }
  scope :post, -> (post) { where post_id: post }

  def post_title
    post.title
  end


end