require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  let!(:question) { create :question }

  describe 'GET #new' do
    login_user
    before { get :new, question_id: question }

    it 'assigns a new Question to @question' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    login_user

    subject(:post_request){ post :create, answer: attributes_for(:answer, user_id: @user), question_id: question }
    context 'with valid attributes' do
      it 'saves the new answer in the database' do
        expect{ post_request }.to change(question.answers, :count).by(1)
      end

      it 'checks that answer belongs to user' do
        expect{ post_request }.to change(@user.answers, :count).by(1)
      end

      it 'render questions' do
        post :create, answer: attributes_for(:answer, user_id: @user), question_id: question
        expect(response).to redirect_to question_path(question)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the answer' do
        expect { post :create, answer: attributes_for(:invalid_answer, user_id: @user), question_id: question }.to_not change(Answer, :count)
      end

      it 're-renders new view' do
        post :create, answer: attributes_for(:invalid_answer, user_id: @user), question_id: question
        expect(response).to render_template :new
      end
    end
  end

  describe 'DELETE #destroy' do
    login_user
    let(:other_user){ create :user }

    context 'user is author answer' do
      login_user
      before do
        @answer = create(:answer, question_id: question.id, user_id: @user.id)
      end

      it 'user author question' do
        expect(@answer.user_id).to eq @user.id
      end

      it 'deletes question' do
        expect { delete :destroy, id: @answer, question_id: question }.to change(Answer, :count).by(-1)
      end

      it 'redirect to index view' do
        delete :destroy, id: @answer, question_id: question
        expect(response).to redirect_to question_path(question)
      end
    end

    context 'user is not author question' do
      before do
        @answer = create(:answer, question_id: question.id, user_id: other_user.id)
      end

      it 'user author question' do
        expect(@answer.user_id).not_to eq @user.id
      end

      it 'deletes question' do
        expect { delete :destroy, id: @answer, question_id: question }.to_not change(Answer, :count)
      end

      it 'render show' do
        delete :destroy, id: @answer, question_id: question
        expect(response).to redirect_to question_path(question)
      end
    end
  end
end
