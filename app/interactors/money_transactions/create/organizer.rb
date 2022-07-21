# frozen_string_literal: true

module MoneyTransactions
  module Create
    class Organizer < BaseOrganizer
      organize Initialize,
               Validate,
               FindReceiver,
               Persist
    end
  end
end
