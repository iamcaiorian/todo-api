class Task < ApplicationRecord
  belongs_to :todolist

  validates :title, presence: true
  validates :todolist_id, presence: true
end
