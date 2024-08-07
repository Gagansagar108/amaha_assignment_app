$redis = Redis.new(
    host: Rails.application.credentials.redis[:host],
    port: Rails.application.credentials.redis[:port],
    password: Rails.application.credentials.redis[:password],
    db: Rails.application.credentials.redis[:db]
  )
