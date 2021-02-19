class TelegramMailer < ApplicationMailer
  def group_message(text)
    api_secret_key = "1629298034:AAF2tH3138rKh1YOFbD_geU9WzaVKeuX0js"
    chat_id = "-574253305"

    HTTParty.post("https://api.telegram.org/bot#{api_secret_key}/sendMessage",
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
    api_secret_key = "1629298034:AAF2tH3138rKh1YOFbD_geU9WzaVKeuX0js"
    chat_id = user.telegram_id

    HTTParty.post("https://api.telegram.org/bot#{api_secret_key}/sendMessage",
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
