require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  let(:question) { create :question }

  describe 'GET #new' do
    before { get :new, question_id: question }

    it 'assigns a new Question to @question' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the new answer in the database' do
        expect { post :create, answer: attributes_for(:answer), question_id: question }.to change(question.answers, :count).by(1)
      end

      it 'render questions' do
        post :create, answer: attributes_for(:answer), question_id: question
        expect(response).to redirect_to questions_path
      end
    end

    context 'with invalid attributes' do
      it 'does not save the answer' do
        expect { post :create, answer: attributes_for(:invalid_answer), question_id: question }.to_not change(Answer, :count)
      end

      it 're-renders new view' do
        post :create, answer: attributes_for(:invalid_answer), question_id: question
        expect(response).to render_template :new
      end
    end
  end
end
