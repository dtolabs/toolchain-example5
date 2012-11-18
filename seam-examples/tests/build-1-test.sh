#!/usr/bin/env roundup
#
# This file contains the test plan for the build command.
# Execute the plan by invoking: 
#    
#     rerun stubbs:test -m seam-examples -p build
#

# Helpers
#
[[ -f ./functions.sh ]] && . ./functions.sh

# The Plan
# --------

describe "build"

it_builds_without_arguments() {
  rerun seam-examples:build
  rm ${RERUN_MODULES}/seam-examples/workspace/booking-rpm/target/rpm/seam-booking-rpm/RPMS/noarch/seam-booking-rpm-3.2.0-1.noarch.rpm
  rerun seam-examples:clean
}
