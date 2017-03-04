class TransactionMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.transaction_mailer.transaction_confirmation.subject
  #
  def transaction_confirmation (transaction)
    @transaction = transaction
    mail to: @transaction.user.email , subject: 'Transaction confirmation'
  end

end
