class TelegramController < ApplicationController
  def telegram_auth
    if params[:id].present?
      current_user.update(telegram_id: params[:id])
    end
    redirect_to user_path(current_user), notice: "Telegram authentication: success"
  end

  # for task
  def send_reminder
    @task = Task.find(params[:id])
    text = "#{url_for controller: "tasks", action: "show"} reminder from #{current_user}"
    if @task.member.user.telegram_id.present?
      TelegramMailer.private_message(text, @task.member.user).deliver_now
      redirect_to @task, notice: "Reminder sent!"
    else
      redirect_to @task, alert: "Mesage not sent. User did not connect telegram"
    end
  end

end