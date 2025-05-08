require 'rails_helper'

RSpec.describe "/tasks", type: :request do

  let(:todolist) { create(:todolist) }

  let(:valid_attributes) {
    {
      title: "Caso de teste válido",
      description: "Este é um caso de teste válido",
      deadline: Time.zone.parse("2025-05-10 12:00"),
      done: false,
      priority: 1,
      todolist_id: todolist.id
    }
  }

  let(:invalid_attributes) {
    {
      title: nil,
      description: "Sem título",
      deadline: nil,
      done: false,
      priority: 1,
      todolist_id: nil 
    }
  }

  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    it "renders a successful response" do
      Task.create! valid_attributes
      get tasks_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      task = Task.create! valid_attributes
      get task_url(task), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Task" do
        expect {
          post tasks_url,
               params: { task: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Task, :count).by(1)
      end

      it "renders a JSON response with the new task" do
        post tasks_url,
             params: { task: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Task" do
        expect {
          post tasks_url,
               params: { task: invalid_attributes }, as: :json
        }.to change(Task, :count).by(0)
      end

      it "renders a JSON response with errors for the new task" do
        post tasks_url,
             params: { task: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {
          title: "Caso de teste válido",
          description: "Este é um caso de teste atualizado",
          deadline: Time.zone.parse("2025-05-10 12:00"),
          done: true,
          priority: 2,
        }
      }

      it "updates the requested task" do
        task = Task.create! valid_attributes
        patch task_url(task),
              params: { task: new_attributes }, headers: valid_headers, as: :json
        task.reload
        
        expect(task.title).to eq("Caso de teste válido")
        expect(task.description).to eq("Este é um caso de teste atualizado")
        expect(task.deadline).to eq(Time.zone.parse("2025-05-10 12:00"))
        expect(task.done).to be true
        expect(task.priority).to eq(2)
        expect(task.todolist_id).to eq(todolist.id)
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end

      it "renders a JSON response with the task" do
        task = Task.create! valid_attributes
        patch task_url(task),
              params: { task: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the task" do
        task = Task.create! valid_attributes
        patch task_url(task),
              params: { task: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested task" do
      task = Task.create! valid_attributes
      expect {
        delete task_url(task), headers: valid_headers, as: :json
      }.to change(Task, :count).by(-1)
    end
  end
end
