# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "../log/cron_log.log"
# set :output, "/log/cron_log.log"
set :output, "log/cron_log.log"

every 30.minutes do # Many shortcuts available: :hour, :day, :month, :year, :reboot
  rake "batch:invite_messages"
end
