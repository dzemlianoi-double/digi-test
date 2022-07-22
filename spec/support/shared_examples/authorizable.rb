# frozen_string_literal: true

RSpec.shared_examples 'authorizable' do
  context 'when user is authenticated' do
    let!(:user) { create(:user) }

    it 'responds with 200' do
      sign_in(user)

      expect(subject).not_to redirect_to(new_user_session_path)
    end
  end

  context 'when user is not_authorized' do
    it 'responds with redirect' do
      expect(subject).to redirect_to(new_user_session_path)
    end
  end
end
