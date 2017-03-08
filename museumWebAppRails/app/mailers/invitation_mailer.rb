class InvitationMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.invitation_mailer.invite.subject
  #
  def invite
    @invite = invitation
  	mail :from => 'DO_NOT_REPLY',
       :to => invitation.email,
       :subject => "Welcome to the Lelooska Museum"
  end
end
