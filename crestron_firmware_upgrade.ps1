# Crestron Firmware Upgrade
# Steve Ruff
# 6/15/2017
# This script reads a CSV-formatted list of rooms, IP addresses, and Crestron device model names,
# connects to the type of device(s) of the user's choosing, logs the current firmware version, applies any
# available firmware upgrades, and logs the new firmware version verifying that the upgrade was completed
# successfully.

function importCSV {
    $filepath = "$PSScriptRoot\ip-addresses-template.csv"
#    $global:devices = Import-Csv $filepath # assign imported CSV data to global $devices array
    $csvData = Import-Csv $filepath
    ForEach ($item in $csvData) {
        $global:roomNumbers += $($item.Room)
        $global:ipAddresses += $($item.IP)
        $global:deviceModels += $($item.Model)
    }
}

function checkVersion {
    # establish ssh connection to each host
    ForEach ($ip in $ipAddresses) {
        New-SSHSession -ComputerName $ip -Credential $credential
    }
    # get firmware version
    ForEach ($heading in $SshSessions) {
        Invoke-SSHCommand -Index $heading.SessionId -Command "version"
    }
    # disconnect from each connected host
    $sessionIndices = @()
    ForEach ($heading in $SshSessions) {
        $sessionIndices += $heading.SessionId
    }
    ForEach ($index in $sessionIndices) {
        Remove-SSHSession -Index $index
    }
}

function uploadFirmware {
    # connect to each device and upload current firmware
    # establish SFTP connection to each host
    ForEach ($ip in $ipAddresses) {
        New-SFTPSession -ComputerName $ip -Credential $credential
    }
}

function applyFirmware {
# connect to each device and apply current firmware upgrade
}

$roomNumbers = @()
$ipAddresses = @()
$deviceModels = @()
importCSV
$credential = Get-Credential -Message "Enter the username and password to use for SSH to Crestron devices."
checkVersion
#uploadFirmware