class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :fetch_question

  def new
    @answer = @question.answers.new
  end

  def create
    answer = @question.answers.new answer_params.merge(user_id: current_user.id)
    if answer.save
      redirect_to question_path(answer.question_id)
    else
      render :new
    end
  end

  def destroy
    answer = Answer.find params.fetch(:id)
    if answer.user == current_user
      answer.destroy
      flash.notice = 'Answer is delete'
    else
      flash.alert = 'Only the author can delete the answer'
    end
    redirect_to question_path(@question)
  end

  private

  def answer_params
    params.require(:answer).permit(:title, :body)
  end

  def fetch_question
    @question = Question.find params.fetch(:question_id)
  end
end
