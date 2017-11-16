class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one :teenager
  has_one :client
  
  acts_as_messageable
  
  def mailboxer_email(object)
    email
  end
end
