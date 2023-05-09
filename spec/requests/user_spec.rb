require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "POST #create" do
    let(:user_params) {
      {
        "name": "ovo da silva sauro",
        "age": 19,
        "gender": "male",
        "position": {
            "lat": "212324",
            "long": "1231"
        }
    }
    }

    it "creates a new user" do
      post "/api/v1/users/create", params: user_params

      expect(response.status).to eq(200)
      expect(User.last.name).to eq(user_params[:name])
      expect(User.last.age).to eq(user_params[:age])
    end
  end

  describe "PUT #update_user_items" do
    it "updates user items" do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      user_item = FactoryBot.create(:user_item, user: user, item: item, quantity: 5)

      
      params = {
        "user_id": user.id,
        "items": [
          {
            "name": "medicine",
            "quantity": "20"
          },
          {
            "name": "ammunition",
            "quantity": "20"
          }
        ]
      }

      put "/api/v1/users/update_user_items", params: params
      expect(response.status).to eq(200)
      expect(user_item.reload.quantity).to eq('5')
    end
  end

  describe "DELETE #delete_user_items" do
    it "deletes user items" do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      user_item = FactoryBot.create(:user_item, user: user, item: item, quantity: 5)

      params = {
        "user_id": user.id,
        "items": [item.name]
      }

      delete "/api/v1/users/delete_user_items", params: params
      expect(response.status).to eq(200)
      expect(UserItem.find_by(id: user_item.id)).to be_nil
    end
  end

  describe "PUT #mark_as_infected" do
    it "marks user as infected" do
      user = FactoryBot.create(:user)
      user2 = FactoryBot.create(:user)
      user3 = FactoryBot.create(:user)
      user4 = FactoryBot.create(:user)

      params = {
        "user_id": user.id,
        "informant_id": user2.id
      }

      params2 = {
        "user_id": user.id,
        "informant_id": user3.id
      }

      params3 = {
        "user_id": user.id,
        "informant_id": user4.id
      }
      put "/api/v1/users/mark_as_infected", params: params
      put "/api/v1/users/mark_as_infected", params: params2
      put "/api/v1/users/mark_as_infected", params: params3
      expect(response.status).to eq(200)
      expect(user.reload.infected?).to be true
    end
  end

  describe "POST #trade_user_items" do
    it "trades user items" do
      proposer_user = FactoryBot.create(:user)
      accepting_user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      item2 = FactoryBot.create(:item, :medicine)
      item3 = FactoryBot.create(:item, :ammunition)
      FactoryBot.create(:user_item, user: proposer_user, item: item, quantity: 20)
      FactoryBot.create(:user_item, user: accepting_user, item: item2, quantity: 20)
      FactoryBot.create(:user_item, user: accepting_user, item: item3, quantity: 20)

      params = {
        "proposer_user": {
          "id": 1,
          "items": [
            {
              "item_id": 1,
              "name": "water",
              "quantity": "15"
            }
          ]
        },
        "accepting_user": {
          "id": 3,
          "items": [
              {
              "item_id": 3,
              "name": "medicine",
              "quantity": "20"
            },
            {
              "item_id": 4,
              "name": "ammunition",
              "quantity": "20"
            }
          ]
        }
      }

      post "/api/v1/users/trade_user_items", params: params
      expect(response.status).to eq(200)

      expect(UserItem.find_by(user: accepting_user, item: item2).quantity).to eq('20')
      expect(UserItem.find_by(user: proposer_user, item: item).quantity).to eq('20')
    end
  end
end
