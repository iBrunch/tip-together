class User < ActiveRecord::Base
  before_save { self.role ||= :member } 
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  enum role: [:member, :admin, :premium]
  has_many :wikis, dependent: :destroy
  
  has_many :collaborators
  has_many :wikis, through: :collaborators
end
