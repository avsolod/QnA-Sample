class AnswersController < ApplicationController
  before_action :set_question

  def new
    @answer = @question.answers.new
  end

  def create
    answer = @question.answers.new answer_params
    if answer.save
      redirect_to questions_path
    else
      render :new
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:title, :body, :question_id)
  end

  def set_question
    @question = Question.find params.fetch(:question_id)
  end
end
