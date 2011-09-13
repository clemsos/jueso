if ! [ -s delayed_job.pids ]; then
  RAILS_ENV=production delayed_job start
fi