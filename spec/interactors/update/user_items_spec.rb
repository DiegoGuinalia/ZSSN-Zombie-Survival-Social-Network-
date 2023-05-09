require 'rails_helper'

RSpec.describe Update::UserItems do
  describe '#call' do
    let(:user) { create(:user) }
    let(:item1) { create(:item) }
    let(:item2) { create(:item, :food) }
    let(:item3) { create(:item, :medicine) }

    context 'when user is infected' do
      it 'does not update the user items' do
        user.update(infected: true)
        result = described_class.call(params: { user_id: user.id, user_item_data: [{ name: 'item1', quantity: 3 }] })
        expect(result.success?).to be(false)
        expect(result.error).to include('user is infected')
      end
    end

    context 'when user is not infected' do
      before do
        user.update(infected: false)
      end

      it 'updates the user items' do
        user.user_items.create(item_id: item1.id, quantity: 2)
        result = described_class.call(params: { user_id: user.id, user_item_data: [{ name: 'item1', quantity: 3 }] })
        expect(result.success?).to be(true)
      end

      it 'creates a new user item if it does not exist' do
        result = described_class.call(params: { user_id: user.id, user_item_data: [{ name: 'item1', quantity: 3 }] })
        expect(result.success?).to be(true)
      end

      it 'updates multiple user items' do
        user.user_items.create(item_id: item2.id, quantity: 2)
        user.user_items.create(item_id: item3.id, quantity: 1)
        result = described_class.call(params: { user_id: user.id, user_item_data: [{ name: 'food', quantity: 3 }, { name: 'medicine', quantity: 2 }] })
        expect(result.success?).to be(true)
      end
    end
  end
end
