# Set the working application directory
# working_directory "/path/to/your/app"
working_directory "/home/ubuntu/web/www.questing.me/app"

# Number of processes
worker_processes 3

# Unicorn PID file location
# pid "/path/to/pids/unicorn.pid"
pid "/home/ubuntu/web/www.questing.me/unicorn.pid"

# Unicorn socket
# listen "/tmp/unicorn.myapp.sock"
listen "/home/ubuntu/web/www.questing.me/unicorn.www.questing.me.sock"

# Path to logs
# stderr_path "/path/to/log/unicorn.log"
# stdout_path "/path/to/log/unicorn.log"
stderr_path "/home/ubuntu/web/www.questing.me/logs/unicorn-err.log"
stdout_path "/home/ubuntu/web/www.questing.me/logs/unicorn-out.log"

# Time out
timeout 15

# Preloading the app - makesspawning a anew worker process quicker when true.
preload_app true

before_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end







