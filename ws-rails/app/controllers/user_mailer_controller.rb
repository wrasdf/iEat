class UserMailerController < ActionMailer::Base

  def send
    @user = User.find(2)
    mail(:to => "#{@user.name} <#{@user.email}>", :subject => "")
  end

end
