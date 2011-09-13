#!/bin/bash

if ! [ -s #{pids_dir}/delayed_job.pid ]; then  
  RAILS_ENV=production #{RAILS_APP}/script/delayed_job start  
fi