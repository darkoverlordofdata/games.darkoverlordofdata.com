###
 * Redis connector for Leaderboard
###
##
#
rediscloud = if process.env.rediscloud_39a84? then JSON.parse(process.env.rediscloud_39a84)

module.exports =
  if rediscloud?
    host        : rediscloud.hostname
    port        : rediscloud.port
    auth_pass   : rediscloud.password
    options:
      auth_pass : rediscloud.password

  else
    host        : 'localhost'
    port        : 6379

