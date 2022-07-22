# frozen_string_literal: true

RSpec.describe MoneyTransactions::CreateForm, type: :model do
  subject { described_class.new(sender: create(:user)) }

  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to allow_value('test@test.com', 'te@te.te', 'te-te@te.te').for(:email) }
  it { is_expected.not_to allow_value('@test.com', 'test').for(:email) }

  it { is_expected.to validate_presence_of(:amount_in_cents) }
  it { is_expected.to validate_numericality_of(:amount_in_cents).only_integer.is_greater_than(0).allow_nil }

  describe 'sender_has_enough_money' do
    let(:sender) { create(:user) }

    before do
      sender.bank_account.update(balance_in_cents: 1000)
    end

    it 'returns error if there is not enough money for sending' do
      form = described_class.new(sender:, email: 'test@test.com', amount_in_cents: 1001)

      expect(form).to be_invalid
      expect(form.errors.messages_for(:amount_in_cents)).to eq(
        [I18n.t('forms.errors.money_transactions.create.amount_in_cents.not_enough')]
      )
    end

    it 'doesnt return error if there is enough money for sending' do
      form = described_class.new(sender:, email: 'test@test.com', amount_in_cents: 1000)

      expect(form).to be_valid
    end
  end
end
