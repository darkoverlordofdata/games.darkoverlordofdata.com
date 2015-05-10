###
 * Cache
 *
 * Hapi managed cache
 *
 *  Use In Memory + Memcached for Hapi managed cache
 *
###
##
#
#
#
memcached = if process.env.memcachedcloud_aaaeb? then JSON.parse(process.env.memcachedcloud_aaaeb)
if memcached?
  memcached = memcached.username+':'+memcached.password+'@'+memcached.servers
else
  memcached = 'localhost:11211'


module.exports = [
  {
    engine: require('catbox-memory')
  }
  {
    name: 'cloud'
    engine: require('catbox-memjs')
    location: memcached
  }
]
