# Description:
#  Makes it rain!
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_SLACK_WEBHOOK_URL
#
images = require './data/images.json'

module.exports = (robot) ->
  robot.router.post '/hubot/stripe', (req, res) ->
    body = if req.body.payload? then JSON.parse req.body.payload else req.body
    return unless body.type == 'charge.succeeded'
    gif = images[Math.floor(Math.random() * images.length)]
    amount = "$#{body.data.object.amount / 100}"
    slack_notification =
      'text': "#{amount} - #{gif}"
      'username': 'Just got paid',
      'icon_emoji': ':heavy_dollar_sign:'
    webhook_url = process.env.HUBOT_SLACK_WEBHOOK_URL
    robot.http(webhook_url).post(slack_notification) (err, res, body) ->
      console.log(res)

