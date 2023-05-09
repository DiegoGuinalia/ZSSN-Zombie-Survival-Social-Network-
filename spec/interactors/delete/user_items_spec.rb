require 'rails_helper'

RSpec.describe Delete::UserItems do
  let(:user) { create(:user) }
  let(:item1) { create(:item) }
  let(:item2) { create(:item, :food) }
  let(:user_item1) { create(:user_item, user: user, item: item1, quantity: 2) }
  let(:user_item2) { create(:user_item, user: user, item: item2, quantity: 3) }

  describe '#call' do
    context 'with valid params' do
      let(:params) { ActionController::Parameters.new({ user_id: user.id, items: [item1.name] }) }
      let(:context) { described_class.call(params: params) }

      before do
        user_item1
        user_item2
      end

      it 'deletes the user item' do
        expect { context }.to change(UserItem, :count).by(-1)
        expect(UserItem.where(user_id: user.id).pluck(:item_id)).not_to include(item1.id)
        expect(UserItem.where(user_id: user.id).pluck(:item_id)).to include(item2.id)
      end

      it 'returns a success status' do
        expect(context.success?).to be true
      end
    end

    context 'with invalid params' do
      let(:params) { ActionController::Parameters.new({ user_id: nil }) }
      let(:context) { described_class.call(params: params) }

      it 'returns a failure status' do
        expect(context.success?).to be false
      end

      it 'returns an error message' do
        expect(context.error).to include(:user_id)
      end
    end
  end
end
