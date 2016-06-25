class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :set_answer, only: [:edit, :update, :destroy]
  before_action :verify_user, only: [:edit, :update, :destroy]

  def create
    @answer = Answer.new(answer_params)
    
    @answer.question_id = params[:question_id]
    @answer.user_id = current_user.id

    @answer.save

    redirect_to "/questions/#{params[:question_id]}"
  end

  def show
  end
  
  def edit
  end

  def update
    if @answer.update(answer_params)
      redirect_to @question
    else
      render :edit
    end
  end

  def destroy
    @answer.destroy
    redirect_to @question
  end

  private
    def set_answer
      @question = Question.find(params[:question_id])
      @answer = @question.answers.find(params[:id])
    end
    
    def verify_user
      redirect_to root_path unless current_user.id == @answer.user_id
    end

    def answer_params
      params.require(:answer).permit(:content)
    end

end