FactoryGirl.define do
  factory :answer do
    title 'MyString'
    body 'MyString'
  end

  factory :invalid_answer, parent: :answer do
    title nil
    body nil
   end
end
