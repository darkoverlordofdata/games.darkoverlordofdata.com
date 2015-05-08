###
 * MemCacheD options
###
##
#
memcachedcloud = if process.env.memcachedcloud_aaaeb? then JSON.parse(process.env.memcachedcloud_aaaeb)

module.exports =
  if memcachedcloud?
    engine      : require('catbox-memcached')
    password    : memcachedcloud.password
    username    : memcachedcloud.username
    location    : memcachedcloud.servers

  else
    engine      : require('catbox-memcached')
    location    : 'localhost:11211'

