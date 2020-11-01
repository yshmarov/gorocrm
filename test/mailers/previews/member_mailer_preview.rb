# Preview all emails at http://localhost:3000/rails/mailers/member_mailer
class MemberMailerPreview < ActionMailer::Preview
  def invited
    MemberMailer.invited(Member.includes(:user).where.not(users: {invited_by_id: nil}).first).deliver_now
  end
end
