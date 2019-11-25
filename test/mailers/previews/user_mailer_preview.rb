# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at
  # http://5c258fa8ebf34e99b08ab8258a405d0f.vfs.cloud9.us-east-2.amazonaws.com/rails/mailers/user_mailer/account_activation.txt?locale=en
  def account_activation
    user = User.first
    user.activation_token = User.new_token
    UserMailer.account_activation(user)
  end

  # Preview this email at
  # http://5c258fa8ebf34e99b08ab8258a405d0f.vfs.cloud9.us-east-2.amazonaws.com/rails/mailers/user_mailer/password_reset
  def password_reset
    UserMailer.password_reset
  end
end
