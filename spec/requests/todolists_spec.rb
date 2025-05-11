require 'rails_helper'

RSpec.describe "/todolists", type: :request do

  let(:valid_attributes) {
    {
      title: "Caso de teste válido",
      subtitle: "Este é um caso de teste válido",
      color: "#000"
    }
  }


  let(:invalid_attributes) {
    {
      title: nil,       
      subtitle: "Faltando título",
      color: "#000"
    }
  }

  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    it "renders a successful response" do
      Todolist.create! valid_attributes
      get todolists_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      todolist = Todolist.create! valid_attributes
      get todolist_url(todolist), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Todolist" do
        expect {
          post todolists_url,
               params: { todolist: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Todolist, :count).by(1)
      end

      it "renders a JSON response with the new todolist" do
        post todolists_url,
             params: { todolist: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Todolist" do
        expect {
          post todolists_url,
               params: { todolist: invalid_attributes }, as: :json
        }.to change(Todolist, :count).by(0)
      end

      it "renders a JSON response with errors for the new todolist" do
        post todolists_url,
             params: { todolist: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {
          title: "Caso de teste atualizado",
          subtitle: "Este é um caso de teste atualizado",
          color: "#FFF"
        }
      }

      it "updates the requested todolist" do
        todolist = Todolist.create! valid_attributes
        patch todolist_url(todolist),
              params: { todolist: new_attributes }, headers: valid_headers, as: :json
        todolist.reload
        
        expect(todolist.title).to eq("Caso de teste atualizado")
        expect(todolist.subtitle).to eq("Este é um caso de teste atualizado")
        expect(todolist.color).to eq("#FFF")
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end

      it "renders a JSON response with the todolist" do
        todolist = Todolist.create! valid_attributes
        patch todolist_url(todolist),
              params: { todolist: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the todolist" do
        todolist = Todolist.create! valid_attributes
        patch todolist_url(todolist),
              params: { todolist: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested todolist" do
      todolist = Todolist.create! valid_attributes
      expect {
        delete todolist_url(todolist), headers: valid_headers, as: :json
      }.to change(Todolist, :count).by(-1)
    end
  end
end