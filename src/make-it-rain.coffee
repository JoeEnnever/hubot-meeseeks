# Description:
#  Makes it rain!
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_SLACK_WEBHOOK_URL
#
images = require './data/gifs.json'

module.exports = (robot) ->
  robot.router.post '/hubot/stripe', (req, res) ->
    body = if req.body.payload? then JSON.parse req.body.payload else req.body
    unless body.type == 'charge.succeeded'
      res.send 'OK'
      return

    gif = images[Math.floor(Math.random() * images.length)]
    amount = "$#{body.data.object.amount / 100}"
    slack_notification =
      'text': "#{amount} - #{gif}"
      'username': 'Just got paid',
      'icon_emoji': ':heavy_dollar_sign:'
    webhook_url = process.env.HUBOT_SLACK_WEBHOOK_URL
    robot
      .http(webhook_url)
      .header('Content-Type', 'application/json')
      .post(JSON.stringify(slack_notification)) (err, slack_res, body) ->
        console.log(err)
        console.log(body)
        res.send 'OK'

