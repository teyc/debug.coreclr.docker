# clean up
Get-EventSubscriber | Unregister-event

$global:last = [DateTime]::Now

.\scripts\Start-FileSystemWatcher.ps1 src\out -recurse -changedaction {
    $now = [DateTime]::Now
    $seconds = ($now - $global:last).TotalSeconds
    if ($seconds -gt 1.0)
    {
        "Stopping docker"
        docker kill demo
        $global:last = $now
    }
}

