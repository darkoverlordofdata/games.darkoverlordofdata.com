###
 * MemCacheD options
###
##
#

if process.env.memcachedcloud_aaaeb?
  memcachedcloud = JSON.parse(process.env.memcachedcloud_aaaeb)
  location = memcachedcloud.servers
else
  location ='localhost:11211'

module.exports =

#  engine      : require('catbox-memcached')
#  location    : location

  engine: require('catbox-memory')

