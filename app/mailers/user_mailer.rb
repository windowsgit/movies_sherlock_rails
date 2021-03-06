class UserMailer < ApplicationMailer
  layout 'user_mailer'

  def follow_up_email(email)
    mail(to: email,
         subject: 'We hope you are enjoying our app!',
         template_path: 'user_mailer',
         template_name: 'follow_up_email'
    )
  end

  def site_statistics_email
    @dashboard = DashboardFacade.new
    mail(to: ENV['ADMIN_EMAIL'],
         subject: 'Week site statistics.',
         template_path: 'user_mailer',
         template_name: 'site_statistics_email'
    )
  end
end
