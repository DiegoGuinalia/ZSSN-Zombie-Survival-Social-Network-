require 'rails_helper'

RSpec.describe Update::InfectedUser do
  let(:user) { create(:user) }
  let(:informant1) { create(:user) }
  let(:informant2) { create(:user) }
  let(:informant3) { create(:user) }

  let!(:infected_user) { create(:infected_user, user_id: user.id, informant_id: informant1.id) }
  let!(:infected_user1) { create(:infected_user, user_id: user.id, informant_id: informant2.id) }

  let(:params) { ActionController::Parameters.new({ user_id: user.id, informant_id: informant3.id }) }
  let!(:context) { double("Context", user: user) }
  
  describe "#call" do
    subject(:interactor) { described_class.call(params: params) }

    context "with valid params" do
      it "creates an infected user history and marks user as infected" do
        expect(InfectedUserContract).to receive(:new).and_return(double(call: double(success?: true)))
        expect(InfectedUser)
          .to receive(:create)
          .with(user_id: params[:user_id], informant_id: params[:informant_id])
          .and_return(true)

        interactor
        expect(user.reload.infected).to be(true)

      end
    end
  end
end
