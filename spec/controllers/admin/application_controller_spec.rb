require "rails_helper"

describe Admin::ApplicationController, type: :controller do
  controller do
    def dummy
      head :ok
    end
  end

  before { routes.draw { get 'dummy' => 'admin/application#dummy' } }

  describe 'authenticate_admin_user! action callback' do
    context 'when user is not signed in' do
      it 'redirects to sign in path' do
        process :dummy, method: :get

        expect(response).to redirect_to '/admin_users/sign_in'
      end
    end

    context 'when user is signed in' do
      let(:admin_user) { create :admin_user }

      before { sign_in admin_user }

      it 'allows access' do
        process :dummy, method: :get

        expect(response).to have_http_status(:success)
      end
    end
  end
end
