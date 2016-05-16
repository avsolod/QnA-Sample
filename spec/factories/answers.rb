FactoryGirl.define do
  factory :answer do
    sequence(:title){ |n| "Answer Title #{n}"}
    body 'Answer body text'
    question
    user
  end

  factory :invalid_answer, parent: :answer do
    title nil
    body nil
   end
end
