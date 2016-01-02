# Description
#   Granting reaction of slack
#
# Configuration
#   HUBOT_SLACK_TOKEN

_           = require 'lodash'
request     = require('request')
target_user = ['boss_sato']

module.exports = (robot) ->
  addReaction = (msg, name = 'anger') ->
    options = {
      url: 'https://slack.com/api/reactions.add'
      qs:  {
        'token':     process.env.HUBOT_SLACK_TOKEN
        'name':      name                                                                                                    
        'channel':   msg.message.rawMessage.channel
        'timestamp': msg.message.rawMessage.ts
      }
    }

    request.post options, (err, res, body) ->
      if err? or res.statusCode isnt 200
        robot.logger.error("Failed to add emoji reaction #{JSON.stringify(err)}")

  robot.hear /.*/i, (msg) ->
    if _.contains target_user, msg.envelope.user.name
      addReaction(msg)
