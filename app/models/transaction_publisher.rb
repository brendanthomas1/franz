class TransactionPublisher
  def self.credit!(account, amount)
    Karafka.producer.produce_sync(
      topic: 'transaction',
      payload: event_payload('credit', account, amount)
    )
  end

  def self.debit!(account, amount)
    Karafka.producer.produce_sync(
      topic: 'transaction',
      payload: event_payload('debit', account, amount)
    )
  end

  private

  def self.event_payload(type, account, amount)
    {
      id: SecureRandom.hex,
      type: type,
      account_id: account.id,
      amount: amount
    }.to_json
  end
end
