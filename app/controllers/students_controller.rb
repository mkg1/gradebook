class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :destroy]
  before_action :authenticate
  before_action :logged_in_as_teacher?, only: [:index, :show, :new, :create, :destroy]
  # before_action :student_is_mine?, only: [:show, :edit, :update, :destroy]
  # GET /students
  # GET /students.json
  def index
    @students = Student.where(teacher_id: session[:user_id])
  end

  # GET /students/1
  # GET /students/1.json
  def show
  end

  # GET /students/new
  def new
    @student = Student.new(teacher_id: session[:user_id])
  end

  # GET /students/1/edit
  def edit
    @student = Student.find(params[:id])
  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new(student_params)
    if @student.save
      redirect_to @student, notice: 'Student was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    @student = Student.find(params[:id])
    if @student.update(student_params)
      redirect_to @student, notice: 'Student was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
    redirect_to students_url, notice: 'Student was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
      unless @student.teacher_id == session[:user_id]
        redirect_to root_path, notice: "Sorry, no access"
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:name, :teacher_id, :email, :password)
    end
end
