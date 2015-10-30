# Description:
#  Does things for you
#
# Dependencies:
#   None
#

module.exports = (robot) ->
  robot.hear /^mr(\.)? meeseeks/i, (msg) ->
    msg.respond ':meeseeks: CAAAAAAAAAN DOOOOOOO!'
