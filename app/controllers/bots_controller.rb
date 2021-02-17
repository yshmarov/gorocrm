class BotsController < ApplicationController

  def say_hello
    api_secret_key = "1629298034:AAF2tH3138rKh1YOFbD_geU9WzaVKeuX0js"
    # https://api.telegram.org/bot1629298034:AAGMejWo9WFeZ-XP51f4Tpbb_L_0t8nO4xM/getUpdates
    chat_id = "-574253305"

    text = "#{current_user} @yarotheslav #{request.url} sorry for spam"

    # HTTParty.post("https://api.telegram.org/bot#{api_secret_key}/sendMessage?chat_id=#{chat_id}&text=#{text}")
    # HTTParty.post('https://api.telegram.org/bot1629298034:AAF2tH3138rKh1YOFbD_geU9WzaVKeuX0js/sendMessage?chat_id=-574253305&text=yo%20bro')
    # HTTParty.post("https://api.telegram.org/bot#{api_secret_key}/sendMessage?chat_id=#{chat_id}&text=#{text}")
    
    # body = {text: "#{current_user} is alive", chat_id: chat_id}
    # HTTParty.post("https://api.telegram.org/bot#{api_secret_key}/sendMessage", body: body)

    HTTParty.post("https://api.telegram.org/bot#{api_secret_key}/sendMessage",
      headers: {
        'Content-Type' => 'application/json'
      },
      body: {
        chat_id: chat_id,
        text: text
      }.to_json
    )
    redirect_to root_path, notice: "message sent"
    # redirect_to dashboard_path, notice: "message sent"
  end

end