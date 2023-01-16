# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#crontab -r
#$ whenever --update-crontab
#
set :output, "./log/slack.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end
every 1.day, at: '3:00 am' do # Mỗi ngày, vào lúc 3 giờ sáng sẽ thực hiện lệnh sau:
  runner 'Micropost.schedule_micropost'
  runner 'User.schedule_user'
  runner 'Comment.schedule_comment'
  runner 'Emote.schedule_emote'
end

# Learn more: http://github.com/javan/whenever
