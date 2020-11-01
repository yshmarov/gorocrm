class MemberMailer < ApplicationMailer
  def invited(new_member)
    @member = new_member
    mail(to: @member.user.email, subject: "You have been invited to join tenant: #{@member.tenant.name}")
  end
end
