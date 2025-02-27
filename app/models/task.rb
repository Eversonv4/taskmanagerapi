class Task < ApplicationRecord
  belongs_to :users

  validates :body, presence: true
end