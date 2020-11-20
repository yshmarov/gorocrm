module SetTimeZone
  extend ActiveSupport::Concern

  included do

    around_action :set_time_zone, if: :current_user
    
    private
  
    def set_time_zone
      time_zone = params["time_zone"]
      if params["time_zone"].present?
        current_user.update(time_zone: time_zone)
        redirect_to user_path(current_user)
      end
      if ActiveSupport::TimeZone.all.map { |tz| tz.tzinfo.name }.include?(current_user.time_zone)
        Time.use_zone(current_user.time_zone) { yield }
      else
        yield
      end
    end

  end
end
