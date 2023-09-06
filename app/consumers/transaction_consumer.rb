# frozen_string_literal: true

class TransactionConsumer < ApplicationConsumer
  def consume
    messages.each do |message|
      account = BankAccount.find(message.payload['account_id'])


      account.update!(balance: account.balance + transaction_amount(message))
    end
  end

  def transaction_amount(message)
    type = message.payload['type']
    amount = message.payload['amount']

    return amount if type == 'debit'
    return -amount if type == 'credit'
  end
end
