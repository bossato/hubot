Netatmo = require('netatmo')
moment  = require('moment')

config =
  client_id:     process.env.NETATMO_CILIENT_ID
  client_secret: process.env.NETATMO_CILIENT_SECRET
  username:      process.env.NETATMO_USERNAME
  password:      process.env.NETATMO_PASSWORD

options =
  device_id: process.env.NETATMO_DEVICE_ID
  scale:     "max"
  date_end:  "last"
  type:      [
    "Temperature"
    "CO2"
    "Humidity"
    "Pressure"
    "Noise"
  ]

moment.lang 'ja', {
  weekdays:      ["日曜日","月曜日","火曜日","水曜日","木曜日","金曜日","土曜日"],
  weekdaysShort: ["日","月","火","水","木","金","土"]
}

module.exports = (robot) ->
  netatmo_api = undefined

  robot.respond /(CO2|二酸化炭素|空気悪い|換気)/i, (msg) ->
    unless netatmo_api
      netatmo_api = new Netatmo config

    netatmo_api.getMeasure options, (err, measure) ->
      temperature = measure[0]['value'][0][0]
      co2         = measure[0]['value'][0][1]
      humidity    = measure[0]['value'][0][2]
      pressure    = measure[0]['value'][0][3]
      noise       = measure[0]['value'][0][4]

      result_comment = if co2 > 1000 then "\n空気悪っ！換気しましょう！オフィスのCO2濃度は1000ppmが目安です。1000ppm超えると眠くなるよ！" else ''
      measure_time   = moment.unix(measure[0]['beg_time']).format("YYYY年MM月DD日(ddd) HH:mm:ss ")

      return msg.send "#{measure_time}に測定した室内環境(dance)\n[info]温度：#{temperature}度\n湿度：#{humidity}%\nCO2：#{co2}ppm\n気圧：#{pressure}hPa\n騒音：#{noise}dB[/info]" + result_comment
