$redis = Redis.new(
    host: ENV.fetch('redis_host') { 'localhost' },
    port: ENV.fetch('redis_port', 6379),
    password: ENV.fetch('redis_password') { Rails.application.credentials.redis[:password] },
    db: 0
  )