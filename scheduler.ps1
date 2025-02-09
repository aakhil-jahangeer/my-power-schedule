# Windows Power Scheduling Script

# Function to schedule a shutdown on Windows
function windows_shutdown {
Write-Host "Scheduling a shutdown on Windows..."
$time = Read-Host "Enter the time for shutdown (HH:MM format)"
$current_time = Get-Date -Format "HH:mm"

if ($time -lt $current_time) {
Write-Host "The time you provided has already passed. Please use a future time."
exit
}

# Schedule shutdown using Task Scheduler
$action = New-ScheduledTaskAction -Execute "shutdown.exe" -Argument "/s /f"
$trigger = New-ScheduledTaskTrigger -At $time -Daily
$task = New-ScheduledTask -Action $action -Trigger $trigger -Description "Scheduled Shutdown"
Register-ScheduledTask -TaskName "ScheduledShutdown" -InputObject $task

Write-Host "Shutdown scheduled for $time."
}

# Function to schedule Wake-on-LAN on Windows
function windows_poweron {
Write-Host "Scheduling Wake-on-LAN on Windows..."
$time = Read-Host "Enter the time for power-on (HH:MM format)"
$mac_address = Read-Host "Enter the MAC address for Wake-on-LAN"

$current_time = Get-Date -Format "HH:mm"

if ($time -lt $current_time) {
Write-Host "The time you provided has already passed. Please use a future time."
exit
}

# Schedule Wake-on-LAN using Task Scheduler (example with wolcmd)
$action = New-ScheduledTaskAction -Execute "C:\path\to\wolcmd.exe" -Argument "$mac_address"
$trigger = New-ScheduledTaskTrigger -At $time -Daily
$task = New-ScheduledTask -Action $action -Trigger $trigger -Description "Scheduled Wake-on-LAN"
Register-ScheduledTask -TaskName "ScheduledPowerOn" -InputObject $task

Write-Host "Wake-on-LAN scheduled for $time with MAC address $mac_address."
}

# Main menu for Windows
Write-Host "Please choose an option:"
Write-Host "1. Schedule Windows Shutdown"
Write-Host "2. Schedule Windows Power-on (WOL)"
Write-Host "3. Exit"

$choice = Read-Host

switch ($choice) {
1 {
windows_shutdown
break
}
2 {
windows_poweron
break
}
3 {
exit
break
}
default {
Write-Host "Invalid option. Exiting."
exit
}
}
