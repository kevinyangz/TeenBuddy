class User < ApplicationRecord
  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]
         
  has_one :teenager, :dependent => :delete
  has_one :client, :dependent => :delete
  has_many :transactions, :dependent => :delete_all

  accepts_nested_attributes_for :teenager
  accepts_nested_attributes_for :client
  acts_as_messageable
  
  def mailboxer_email(object)
    email
  end

  def self.from_omniauth(auth)
     where(provider: auth.provider, uid: auth.uid).first

  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"]
        user.email = data["info"]["email"] if user.email.blank?
        user.provider = data["provider"]
        user.uid = data["uid"]
        user.password = Devise.friendly_token[0,20]
        puts 'here is the provider'
        puts( session["devise.facebook_data"].map{ |k,v| "#{k} => #{v}" }.sort )
      end
    end
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
