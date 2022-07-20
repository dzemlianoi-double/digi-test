# frozen_string_literal: true

RSpec.describe ApplicationHelper do
  describe '#active_class' do
    let(:current_path) { '/test' }

    it 'returns active if current page is active' do
      allow(helper).to receive(:current_page?).with(current_path) { true }

      expect(helper.active_class(current_path)).to eq 'active'
    end

    it 'returns empty string if current page is not active' do
      allow(helper).to receive(:current_page?).with(current_path) { false }

      expect(helper.active_class(current_path)).to eq ''
    end
  end
end
