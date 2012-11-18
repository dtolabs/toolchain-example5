#!/usr/bin/env roundup
#
# This file contains the test plan for the build-module command.
# Execute the plan by invoking: 
#    
#     rerun stubbs:test -m booking-application-server -p build-module
#

# The Plan
# --------

describe "build-module"


it_runs_without_arguments() {

  rerun booking-application-server:build-module
  rm ${RERUN_MODULES}/rerun-booking-application-server-1.0-1.noarch.rpm
}

