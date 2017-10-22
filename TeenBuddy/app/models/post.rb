class Post < ApplicationRecord
  belongs_to :client
  belongs_to :service
  #has_many :apply

end
