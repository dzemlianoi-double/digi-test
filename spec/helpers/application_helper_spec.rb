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

    describe '#flash_class' do
      it 'return correct class list for notice' do
        expect(helper.flash_class(:notice)).to eq('alert alert-success')
      end

      it 'return correct class list for success' do
        expect(helper.flash_class(:success)).to eq('alert alert-success')
      end

      it 'return correct class list for error' do
        expect(helper.flash_class(:error)).to eq('alert alert-danger')
      end

      it 'return correct class list for alert' do
        expect(helper.flash_class(:alert)).to eq('alert alert-danger')
      end
    end
  end
end
