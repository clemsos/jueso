if ! [ -s delayed_job.pids ]; then
  RAILS_ENV=production /script/delayed_job start
end