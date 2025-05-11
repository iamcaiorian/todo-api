require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      task = build(:task)
      expect(task).to be_valid
    end

    it 'is invalid without a title' do
      task = build(:task, title: nil)
      expect(task).not_to be_valid
    end

    it 'is invalid without a todo_list' do
      task = build(:task, todolist: nil)
      expect(task).not_to be_valid
    end
  end

  describe 'associations' do
    it { should belong_to(:todolist) }
  end
end