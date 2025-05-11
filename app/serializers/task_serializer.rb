class TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :deadline, :done, :priority
  has_one :todolist
end
