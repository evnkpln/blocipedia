class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  before_save { self.role ||= :free}
  enum role: [:free, :premium, :admin]
  has_many :wikis
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

end
