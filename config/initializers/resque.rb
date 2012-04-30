uri = URI.parse(ENV["REDISTOGO_URL"])
Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
Resque.after_fork = Proc.new { ActiveRecord::Base.establish_connection }