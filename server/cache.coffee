module.exports =
  if (c = process.env.memcachedcloud_aaaeb)?
    engine: require('catbox-memcached')
    password: c.password
    username: c.username
    location: c.servers
  else
    engine: require('catbox-memcached')
    location: 'localhost:11211'

