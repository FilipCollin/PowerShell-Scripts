function Monitor-CPUsage {

$Timer = New-Object -TypeName System.Diagnostics.Stopwatch
$Timer.Start()

notepad.exe
Write-Host -ForegroundColor Red "Opened notepad, do not close notepad until you're done. Closing notepad will stop the CPU usage monitoring."
Write-Host -ForegroundColor Red "Could've done it better I know :)"
do {

    $CPU = Get-CimInstance -ClassName Win32_Processor
    if ($cpu.LoadPercentage -gt 70) {
        
       Write-Host -ForegroundColor Red "CPU Usage: $($CPU.LoadPercentage)%"
                                                                 
    }
    else {
        
       Write-Host -ForegroundColor Green "CPU Usage: $($CPU.LoadPercentage)%"

    }
    $process = Get-Process | where { $_.Name -eq 'Notepad'}

    [int[]]$count = $count += $CPU.LoadPercentage

    Start-Sleep 2
}
until ($Process.Name -notcontains 'Notepad')

$Timer.Stop()

$count | foreach {

    $AllCount = $AllCount + $_

}
$CPUAverage = $AllCount / $count.Length

$Usage     = $count | measure -Maximum -Minimum
Write-Host -ForegroundColor DarkYellow "Run time: $("{0:n0}" -f $Timer.Elapsed.TotalHours)h, $("{0:n0}" -f $Timer.Elapsed.TotalMinutes)min and $("{0:n0}" -f $Timer.Elapsed.Seconds)sec"
Write-Host -ForegroundColor DarkYellow "Maximum percentage of usage: $($Usage.Maximum)%"
Write-Host -ForegroundColor DarkYellow "Minimum percentage of usage: $($Usage.Minimum)%"
Write-Host -ForegroundColor DarkYellow "The average CPU usage were: $("{0:n0}%" -f $CPUAverage)"

}
