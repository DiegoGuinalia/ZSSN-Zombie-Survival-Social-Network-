require 'rails_helper'

RSpec.describe Trade::UserItems do
  let!(:user) { create(:user) }
  let!(:user2) { create(:user) }

  let!(:water) { create(:item) }
  let!(:medicine) { create(:item, :medicine) }

  let!(:user_item) { create(:user_item, user_id: user.id, item_id: water.id, quantity: '10') }
  let!(:user_item1) { create(:user_item, user_id: user.id, item_id: medicine.id, quantity: '10') }
  let!(:user_item2) { create(:user_item, user_id: user2.id, item_id: water.id, quantity: '10') }

  let(:proposer_user) { { id: user2.id, items: [{ item_id: 3,name: 'medicine', quantity: 2 }, {item_id: 1, name: 'water', quantity: 1 }] } }
  let(:accepting_user) { { id: user.id, items: [{item_id: 1, name: 'water', quantity: 2 }] } }

  let(:params) { { proposer_user: proposer_user, accepting_user: accepting_user } }
  let(:context) { Trade::UserItems.call(params) }

  context 'when both users have enough points to trade' do
    it 'trades items between users' do
      expect { context }.to change { UserItem.count }.by(1)

      proposer_user_item1 = User.find(proposer_user[:id]).user_items.find_by(item_id: water.id)
      accepting_user_item1 = User.find(accepting_user[:id]).user_items.find_by(item_id: medicine.id)
      accepting_user_item2 = User.find(accepting_user[:id]).user_items.find_by(item_id: water.id)

      expect(proposer_user_item1.quantity).to eq((user_item.quantity.to_f - 1).to_s)
      expect(accepting_user_item1.quantity).to eq((user_item1.quantity.to_f - 2).to_s)
      expect(accepting_user_item2.quantity).to eq((user_item.quantity.to_f + 1).to_s)
    end
  end

  context 'when one user does not have enough points to trade' do
    let(:proposer_user) { { id: 1, items: [{ name: 'medicine', quantity: 2 }, { name: 'water', quantity: 1 }] } }
    let(:accepting_user) { { id: 2, items: [{ name: 'food', quantity: 1 }] } }

    it 'does not trade items between users and fails' do
      expect { context }.to_not change { UserItem.count }
      expect(context).to be_failure
      expect(context.error).to eq("item doesn't exist/invalid quantity")
    end
  end
end
