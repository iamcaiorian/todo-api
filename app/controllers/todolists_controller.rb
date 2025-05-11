class TodolistsController < ApplicationController
  before_action :set_todolist, only: %i[ show update destroy tasks ]

  # GET /todolists
  def index
    @todolists = Todolist.all

    render json: @todolists
  end

  # GET /todolists/1
  def show
    render json: @todolist
  end

  # GET /todolists/:id/tasks
  def tasks
    render json: @todolist.tasks
  end

  # POST /todolists
  def create
    @todolist = Todolist.new(todolist_params)

    if @todolist.save
      render json: @todolist, status: :created, location: @todolist
    else
      render json: @todolist.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /todolists/1
  def update
    if @todolist.update(todolist_params)
      render json: @todolist
    else
      render json: @todolist.errors, status: :unprocessable_entity
    end
  end

  # DELETE /todolists/1
  def destroy
    @todolist.destroy!
  end

  private
    def set_todolist
      @todolist = Todolist.find(params.expect(:id))
    end

    def todolist_params
      params.expect(todolist: [ :title, :subtitle, :color ])
    end
end