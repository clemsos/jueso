if ![ -s /home/jue/apps/jueso/shared/pids/delayed_job.pids ]; then
  RAILS_ENV=production 	/home/jue/apps/jueso/current/script/delayed_job start
fi