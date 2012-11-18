#!/usr/bin/env roundup
#
# This file contains the test plan for the clean command.
# Execute the plan by invoking: 
#    
#     rerun stubbs:test -m seam-examples -p clean
#

# Helpers
#
[[ -f ./functions.sh ]] && . ./functions.sh

# The Plan
# --------

describe "clean"

it_runs_without_arguments() {
 rerun seam-examples:clean
}
