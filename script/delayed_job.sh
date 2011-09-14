if ! [ -s delayed_job.pids ]; then
  RAILS_ENV=production /app/script/delayed_job start
fi