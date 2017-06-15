# Crestron Firmware Upgrade
# Steve Ruff
# 6/15/2017
# This script reads a CSV-formatted list of rooms, IP addresses, and Crestron device model names,
# connects to the type of device(s) of the user's choosing, logs the current firmware version, applies any
# available firmware upgrades, and logs the new firmware version verifying that the upgrade was completed
# successfully.

function importCSV {
#	import device information from CSV file into array
}

function checkVersion {
#	connect to each device and check current firmware version
}

function uploadFirmware {
# connect to each device and upload current firmware
}

function applyFirmware {
# connect to each device and apply current firmware upgrade
}