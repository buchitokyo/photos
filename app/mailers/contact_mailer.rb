class ContactMailer < ApplicationMailer
  def contact_mail(picture)
    @picture = picture
    @contact_user = @picture.user.email
    mail to: @contact_user, subject: "お問い合わせの確認メール"
  end
end
