require 'rails_helper'

feature 'Questions', %q{

} do

  given!(:user){ create :user_with_questions }
  given(:question){ create :question }

  describe 'Authenticated user'  do
    before do
      login(user)
    end

    scenario 'create question' do
      visit questions_path
      click_on 'Ask question'
      fill_in 'Title', with: 'question.title'
      fill_in 'Body', with: 'question.body'
      click_on 'Create question'

      expect(page).to have_content 'question.title'
      expect(page).to have_content 'question.body'
    end

    scenario 'author removes your question' do
      question = user.questions.first
      visit question_path(question)
      click_on "DELETE QUESTION #{question.id}"

      expect(current_path).to eq questions_path
      expect(page).to have_content 'Question is delete'
      expect(page).to have_no_content question.title
    end

    scenario 'user try removes not your question' do
      visit question_path(question)

      expect(page).to have_no_content "DELETE QUESTION #{question.id}"
    end

    scenario 'view questions' do
      visit questions_path

      expect(page).to have_content user.questions.first.title
      expect(page).to have_content user.questions.last.title
    end
  end


  scenario 'Non-authenticated user create question' do
    visit questions_path

    expect(page).to have_content user.questions.first.title
    expect(page).to have_content user.questions.last.title

    visit question_path(question)

    expect(page).to have_content question.body
    expect(page).to have_no_content 'Create question'
    expect(page).to have_no_content 'DELETE QUESTION'
  end
end

