class Api::V1::VacanciesController < ApplicationController
before_action :set_vacancy, only: [:show, :update, :destroy]

  # GET /todos
  def index
    @vacancies = Vacancy.all
    json_response(@vacancies)
  end

  # POST /todos
  def create
    @vacancy = Vacancy.create!(vacancy_params)
    json_response(@vacancy, :created)
  end

  # GET /todos/:id
  def show
    json_response(@vacancy)
  end

  # PUT /todos/:id
  def update
    @vacancy.update(vacancy_params)
    head :no_content
  end

  # DELETE /todos/:id
  def destroy
    @vacancy.destroy
    head :no_content
  end

  private

  def vacancy_params
    # whitelist params
    params.permit(:title,:salary,:requipment,:description,:expired)
  end

  def set_vacancy
    @vacancy = Vacancy.find(params[:id])
  end
end
