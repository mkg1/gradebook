class ParentsController < ApplicationController
  before_action :set_parent, only: [:show, :edit, :update, :destroy]
  before_action :authenticate
  before_action :logged_in_as_teacher?, only: [:new, :edit, :update, :destroy]

  # GET /parents
  # GET /parents.json
  def index
    user_id = session[:user_id]
    user_type = session[:user_type]
    if session[:user_type] == "Teacher"
      @parents = Parent.all
    elsif session[:user_type] == "Student"
      student = Student.find(user_id)
      @parents = Parent.where(student_id: student.id)
    end

  end

  # GET /parents/1
  # GET /parents/1.json
  def show
  end

  # GET /parents/new
  def new
    @parent = Parent.new(:student_id=>params[:student_id])
  end

  # GET /parents/1/edit
  def edit
  end

  # POST /parents
  # POST /parents.json
  def create
    @parent = Parent.new(parent_params)
    if @parent.save
      redirect_to @parent, notice: 'Parent was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /parents/1
  # PATCH/PUT /parents/1.json
  def update
    if @parent.update(parent_params)
      redirect_to @parent, notice: 'Parent was successfully updated.'
    else
      format.html { render :edit }
    end
  end

  # DELETE /parents/1
  # DELETE /parents/1.json
  def destroy
    @parent.destroy
    redirect_to parents_url, notice: 'Parent was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_parent
      @parent = Parent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def parent_params
      params.require(:parent).permit(:name, :student_id, :email, :password)
    end
end
