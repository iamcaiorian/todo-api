class TodolistSerializer < ActiveModel::Serializer
  attributes :id, :title, :subtitle, :color
end