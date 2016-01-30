Netatmo = require('netatmo')
moment  = require('moment')

config =
  client_id:     process.env.NETATMO_CILIENT_ID
  client_secret: process.env.NETATMO_CILIENT_SECRET
  username:      process.env.NETATMO_USERNAME
  password:      process.env.NETATMO_PASSWORD

types = [
  "Temperature"
  "CO2"
  "Humidity"
  "Pressure"
  "Noise"
]

options =
  device_id: process.env.NETATMO_DEVICE_ID
  scale:     "max"
  date_end:  "last"
  type:      types

moment.lang 'ja', {
  weekdays:      ["日曜日", "月曜日", "火曜日", "水曜日", "木曜日", "金曜日", "土曜日"],
  weekdaysShort: ["日", "月", "火", "水", "木", "金", "土"]
}

module.exports = (robot) ->
  netatmo_api = undefined

  robot.respond /(CO2|二酸化炭素|空気悪い|換気)/i, (msg) ->
    unless netatmo_api
      netatmo_api = new Netatmo config

    netatmo_api.getMeasure options, (err, measure) ->
      response    = measure[0]['value'][0]
      temperature = response[0]
      co2         = response[1]
      humidity    = response[2]
      pressure    = response[3]
      noise       = response[4]

      measure_time   = moment.unix(measure[0]['beg_time']).format("YYYY年MM月DD日(ddd) HH:mm:ss ")
      message = "#{measure_time}に測定した室内環境(dance)\n"
      message += "[info]"
      message += "温度：#{temperature}度\n"
      message += "湿度：#{humidity}%\n"
      message += "CO2：#{co2}ppm\n"
      message += "気圧：#{pressure}hPa\n"
      message += "騒音：#{noise}dB\n"
      message += "[/info]"
      if co2 > 1000
        message += "\n空気が悪いので換気しましょう！オフィスのCO2濃度は1000ppmが目安です！"

      return msg.send message
