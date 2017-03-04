class BorrowMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.borrow_mailer.borrow_confirmation.subject
  #
  def borrow_confirmation(borrow)
    @borrow = borrow
    mail to: @borrow.user.email , subject: 'Borrow request information'
  end

end
