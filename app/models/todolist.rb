class Todolist < ApplicationRecord
    has_many :tasks, dependent: :destroy
    
    validates :title, presence: true
end