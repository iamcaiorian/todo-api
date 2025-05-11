require 'rails_helper'

RSpec.describe Todolist, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      todolist = build(:todolist)
      expect(todolist).to be_valid
    end

    it 'is invalid without a title' do
      todolist = build(:todolist, title: nil)
      expect(todolist).not_to be_valid
    end
  end
end