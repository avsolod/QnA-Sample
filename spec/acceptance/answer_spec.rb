require 'rails_helper'

feature 'Answers', %q{

} do
  given!(:user){ create :user }
  given!(:question){ create :question }
  given!(:answer){ create :answer, question: question, user: user }

  describe 'Authenticated user' do
    before do
      login(user)
    end

    scenario 'Authenticated user create answer' do
      visit new_question_answer_path(question)
      fill_in 'Title', with: 'answer title'
      fill_in 'Body', with: 'answer body'
      click_on 'Create answer'

      expect(current_path).to eq question_path(question)
      expect(page).to have_content 'answer title'
      expect(page).to have_content 'answer body'

    end

    scenario 'author removes your answer' do
      visit question_path(question)
      expect(answer.user_id).to eq user.id
      click_on "DELETE Answer #{answer.id}"

      expect(current_path).to eq question_path(question)
      expect(page).to have_no_content answer.title
      expect(page).to have_content 'Answer is delete'
    end

    given!(:other_user){ create :user }
    given!(:other_answer){ create :answer, question: question, user: other_user }
    scenario 'user try removes not your answer' do
      visit question_path(question)
      expect(page).to have_no_content "DELETE Answer #{other_answer.id}"
    end
  end

  scenario 'Non-authenticated user' do
    visit question_path(question)

    expect(page).to have_content answer.body
    expect(page).to have_no_content "Create answer"
    expect(page).to have_no_content "DELETE Answer #{answer.id}"
  end
end
