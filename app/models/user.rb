class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tweets

  serialize :following, Array

  validates :username, presence: true, uniqueness: true
  validates :name, presence: true

  mount_uploader :avatar, AvatarUploader
end
