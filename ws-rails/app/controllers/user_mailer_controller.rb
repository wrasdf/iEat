class UserMailerController < ActionMailer::Base

  default from: "wr_asdf@163.com"

  def confirm
    @user = User.find(params[:id])
    puts @user
    @message = "Thank you for confirmation!"
    mail(:to => @user.email, :subject => "Registered")
  end

end