# Script PowerShell untuk memulai layanan SMB dan membuka port firewall untuk SMB

# Mulai layanan Workstation (dependensi dari layanan Server)
Write-Output "Memulai layanan Workstation (lanmanworkstation)..."
Start-Service -Name "lanmanworkstation"

# Tunggu sebentar agar layanan Workstation benar-benar berjalan
Start-Sleep -Seconds 5

# Mulai layanan Server (lanmanserver)
Write-Output "Memulai layanan Server (lanmanserver)..."
try {
    Start-Service -Name "lanmanserver"
    Write-Output "Layanan Server (lanmanserver) telah dimulai."
} catch {
    Write-Output "Gagal memulai layanan Server (lanmanserver): $_"
}

# Aktifkan layanan Server agar berjalan otomatis saat startup
Write-Output "Mengatur layanan Server agar berjalan otomatis saat startup..."
Set-Service -Name "lanmanserver" -StartupType Automatic

# Buka port 445 di firewall untuk SMB
Write-Output "Membuka port 445 di firewall untuk SMB..."
New-NetFirewallRule -DisplayName "Allow SMB (TCP 445)" -Direction Inbound -LocalPort 445 -Protocol TCP -Action Allow

# Buka port 139 di firewall untuk SMB (opsional)
Write-Output "Membuka port 139 di firewall untuk SMB..."
New-NetFirewallRule -DisplayName "Allow SMB (TCP 139)" -Direction Inbound -LocalPort 139 -Protocol TCP -Action Allow

Write-Output "Layanan SMB telah dimulai dan port firewall telah dibuka."
