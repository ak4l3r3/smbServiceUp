# Script PowerShell untuk memulai layanan SMB dan membuka port firewall untuk SMB

# Mulai layanan Server (lanmanserver)
Write-Output "Memulai layanan Server (lanmanserver)..."
Start-Service -Name "lanmanserver"

# Aktifkan layanan Server agar berjalan otomatis saat startup
Write-Output "Mengatur layanan Server agar berjalan otomatis saat startup..."
Set-Service -Name "lanmanserver" -StartupType Automatic

# Buka port 445 di firewall untuk SMB
Write-Output "Membuka port 445 di firewall untuk SMB..."
New-NetFirewallRule -DisplayName "Allow SMB (TCP 445)" -Direction Inbound -LocalPort 445 -Protocol TCP -Action Allow

Write-Output "Layanan SMB telah dimulai dan port firewall telah dibuka."
