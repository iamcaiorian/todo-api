class Task < ApplicationRecord
  belongs_to :todolist

  validates :title, presence: true
  validates :todolist, presence: true
end
