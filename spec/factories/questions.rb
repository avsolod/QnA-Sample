FactoryGirl.define do
  factory :question do
    sequence(:title){ |n| "Question title #{n}"}
    body 'Question body text'
    association :user
  end

  factory :invalid_question, parent: :question do
    title nil
    body nil
  end
end
