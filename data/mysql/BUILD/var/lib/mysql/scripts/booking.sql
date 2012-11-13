#
# Drop and create the database:
#
DROP DATABASE IF EXISTS booking;
CREATE DATABASE booking;
#
# Create the user, set the default password and grant access to the database:
#
GRANT ALL PRIVILEGES ON booking.* TO 'booking'@'localhost' IDENTIFIED BY 'booking' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON booking.* TO 'booking'@'%' IDENTIFIED BY 'booking' WITH GRANT OPTION;
