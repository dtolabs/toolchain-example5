#!/usr/bin/env roundup
#
# This file contains the test plan for the create-jobs command.
# Execute the plan by invoking: 
#    
#     rerun stubbs:test -m mysql-connector-java-rpm -p create-jobs
#

# The Plan
# --------

describe "create-jobs"

it_can_create_the_jenkins_jobs() {
    rerun mysql-connector-java-rpm:create-jobs
}

