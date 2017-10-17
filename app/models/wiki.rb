class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators
  validates :body, presence: { message: "Body cannot be blank." }
  validates :title, presence: { message: "Title cannot be blank." }
  
  after_initialize :set_default_values, unless: :private
    def set_default_values
      self.private = false
    end
end
