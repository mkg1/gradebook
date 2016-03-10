class GradesController < ApplicationController
  before_action :authenticate
  before_action :set_grade, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_as_teacher?, only: [:new, :edit, :update, :destroy]


  # GET /grades
  # GET /grades.json
  def index
    user_id = session[:user_id]
    user_type = session[:user_type]
    if session[:user_type] == "Teacher"
      @grades = Grade.all
    elsif session[:user_type] == "Student"
      @grades = Grade.where(student_id: user_id)
    elsif session[:user_type] == "Parent"
      parent = Parent.find(user_id)
      @grades = Grade.where(student_id: parent.student_id)
    else
      redirect_to root_path, notice: "jf;af;djf"
    end
  end

  # GET /grades/1
  # GET /grades/1.json
  def show
  end

  # GET /grades/new
  def new
    @grade = Grade.new(:student_id=>params[:student_id])
  end

  # GET /grades/1/edit
  def edit
  end

  # POST /grades
  # POST /grades.json
  def create

    @grade = Grade.new(grade_params)
    if @grade.save
      redirect_to @grade, notice: 'Grade was successfully created.'
    else
      render :new
    end
  end


  # PATCH/PUT /grades/1
  # PATCH/PUT /grades/1.json
  def update
    if @grade.update(grade_params)
      redirect_to @grade, notice: 'Grade was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /grades/1
  # DELETE /grades/1.json
  def destroy
    @grade.destroy
    redirect_to grades_url, notice: 'Grade was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_grade
      @grade = Grade.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def grade_params
      params.require(:grade).permit(:assignment_name, :grade, :student_id, :date)
    end
end
