class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :pages, dependent: :destroy
  has_many :collabs
  has_many :users, through: :collabs
end
