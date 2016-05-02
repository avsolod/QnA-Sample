FactoryGirl.define do
  factory :question do
    title 'MyString'
    body 'MyString'
  end

  factory :invalid_question, parent: :question do
    title nil
    body nil
  end
end
