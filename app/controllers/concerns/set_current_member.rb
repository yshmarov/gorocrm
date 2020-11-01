module SetCurrentMember
  extend ActiveSupport::Concern

  included do
    before_action :set_current_member
    def set_current_member
      @current_member = Member.find_by(user: current_user)
    end
  end
end
