class TelegramMailer < ApplicationMailer
  def group_message(text)
    chat_id = "-574253305"

    HTTParty.post("https://api.telegram.org/bot#{TELEGRAM}/sendMessage",
      headers: {
        'Content-Type' => 'application/json'
      },
      body: {
        chat_id: chat_id,
        text: text
      }.to_json
    )
  end

  def private_message(text, user)
    chat_id = user.telegram_id

    HTTParty.post("https://api.telegram.org/bot#{TELEGRAM}/sendMessage",
      headers: {
        'Content-Type' => 'application/json'
      },
      body: {
        chat_id: chat_id,
        text: text
      }.to_json
    )
  end

end
