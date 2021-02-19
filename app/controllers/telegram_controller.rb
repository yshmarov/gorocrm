class TelegramController < ApplicationController
  def telegram_auth
    if params[:id].present?
      current_user.update(telegram_id: params[:id])
    end
    redirect_to user_path(current_user), notice: "Telegram authentication: success"
  end
end