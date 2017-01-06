	class UserMailer < ApplicationMailer

  def orders_success(user)
    @user = user
    mail to: user.email, subject: "Orders success"
  end
end
