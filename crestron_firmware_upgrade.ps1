# Crestron Firmware Upgrade
# Steve Ruff
# 6/15/2017
# This script reads a CSV-formatted list of rooms, IP addresses, and Crestron device model names,
# connects to the type of device(s) of the user's choosing, logs the current firmware version, applies any
# available firmware upgrades, and logs the new firmware version verifying that the upgrade was completed
# successfully.

Clear-Host
$devices = @() # instantiate an empty array
importCSV
checkVersion

function importCSV {
    $filepath = "$PSScriptRoot\ip-addresses-template.csv"
    $global:devices = Import-Csv $filepath # assign imported CSV data to global $devices array
}

function checkVersion {
    # establish ssh connection to each host
    ForEach ($heading in $devices) {
        New-SSHSession -ComputerName $heading.IP -Credential (Get-Credential crestron)
        Invoke-SSHCommand -Index 0 -Command "version" # need to figure out how to iterate through indices of all connected ssh sessions to run this command
    }

}

function uploadFirmware {
# connect to each device and upload current firmware
}

function applyFirmware {
# connect to each device and apply current firmware upgrade
}