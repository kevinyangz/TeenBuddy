class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]
  has_one :teenager
  has_one :client
  has_many :transactions

  accepts_nested_attributes_for :teenager
  accepts_nested_attributes_for :client
  acts_as_messageable
  
  def mailboxer_email(object)
    email
  end

  def self.from_omniauth(auth)
    puts auth.info.email
    model=where(email: auth.info.email).first
    return model if model
  end

  def balance
    self.transactions.where(inout:true).sum(:amount) -  self.transactions.where(inout:false).sum(:amount)
  end

  def onhold
    if self.teenager
      0
    elsif self.client
      self.client.posts.sum(:credit)
    else
      0
    end

  end
  
end
