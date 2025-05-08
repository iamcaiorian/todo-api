class Task < ApplicationRecord
  belongs_to :todolist

  validates :title, presence: true
end
