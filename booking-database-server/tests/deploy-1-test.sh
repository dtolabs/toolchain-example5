#!/usr/bin/env roundup
#
# This file contains the test plan for the deploy command.
# Execute the plan by invoking: 
#    
#     rerun stubbs:test -m booking-database-server -p deploy
#

# The Plan
# --------

describe "deploy"


it_can_deploy_the_database_server() {
    rerun booking-database-server:deploy --data-package-file $RERUN_MODULES/booking-database-server/examples/booking-mysql-data-1.0-1.noarch.rpm
    rerun booking-database-server:deploy --data-package-file $RERUN_MODULES/booking-database-server/examples/booking-mysql-data-1.0-1.noarch.rpm
    rerun booking-database-server:remove
}
