class UserMailer < ApplicationMailer

  def orders_success(user, content)
    @user = user
    mail to: user.email, subject: content
  end
end
