#require 'telegram/bot'
#
#token = '1629298034:AAF2tH3138rKh1YOFbD_geU9WzaVKeuX0js'
#
#Telegram::Bot::Client.run(token) do |bot|
#  bot.listen do |message|
#    case message.text
#    when '/start'
#      #bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
#      bot.api.send_message(chat_id: message.chat.id, text: "Your chat ids: #{message.chat.id}")
#    when '/stop'
#      bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
#    end
#  end
#end
#