while ($true) {
    $battery = Get-WmiObject -Class BatteryStatus -Namespace root\wmi
    $timestamp = Get-Date -Format "HH:mm:ss"
    $rate_mW = $battery.ChargeRate
    $rate_W = [math]::Round($rate_mW / 1000, 2)
    $rate_kW = [math]::Round($rate_mW / 1000000, 4)

    Write-Host "$timestamp → ChargeRate: $rate_mW mW = $rate_W W = $rate_kW kW"
    Start-Sleep -Seconds 5
}
