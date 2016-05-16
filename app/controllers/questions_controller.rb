class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i(index show)
  before_action :fetch_question, only: %i(show destroy)

  def index
    @questions = Question.all
  end

  def new
    @question = current_user.questions.new
  end

  def create
    @question = current_user.questions.new question_params
    if @question.save
      redirect_to question_path(@question)
    else
      render :new
    end
  end

  def show; end

  def destroy
    if @question.user == current_user
      @question.destroy
      redirect_to questions_path, notice: 'Question is delete'
    else
      flash.alert = 'Only author deleted question'
      render :show
    end
  end

  private

  def fetch_question
    @question = Question.find params.fetch(:id)
  end

  def question_params
    params.require(:question).permit :title, :body
  end
end
