FactoryBot.define do
  factory :task do
    title { "MyString" }
    description { "MyText" }
    deadline { "2025-05-07 15:00:51" }
    done { false }
    priority { 1 }
    association :todolist
  end
end