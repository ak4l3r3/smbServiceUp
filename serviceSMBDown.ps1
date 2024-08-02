# Script PowerShell untuk menghentikan layanan SMB dan menutup port firewall untuk SMB

# Hentikan layanan Server (lanmanserver)
Write-Output "Menghentikan layanan Server (lanmanserver)..."
try {
    Stop-Service -Name "lanmanserver" -Force
    Write-Output "Layanan Server (lanmanserver) telah dihentikan."
} catch {
    Write-Output "Gagal menghentikan layanan Server (lanmanserver): $_"
}

# Nonaktifkan layanan Server agar tidak berjalan otomatis saat startup
Write-Output "Menonaktifkan layanan Server agar tidak berjalan otomatis saat startup..."
Set-Service -Name "lanmanserver" -StartupType Disabled

# Hentikan layanan Workstation (lanmanworkstation)
Write-Output "Menghentikan layanan Workstation (lanmanworkstation)..."
try {
    Stop-Service -Name "lanmanworkstation" -Force
    Write-Output "Layanan Workstation (lanmanworkstation) telah dihentikan."
} catch {
    Write-Output "Gagal menghentikan layanan Workstation (lanmanworkstation): $_"
}

# Nonaktifkan layanan Workstation agar tidak berjalan otomatis saat startup
Write-Output "Menonaktifkan layanan Workstation agar tidak berjalan otomatis saat startup..."
Set-Service -Name "lanmanworkstation" -StartupType Disabled

# Tutup port 445 di firewall untuk SMB
Write-Output "Menutup port 445 di firewall untuk SMB..."
Get-NetFirewallRule -DisplayName "Allow SMB (TCP 445)" | Remove-NetFirewallRule

# Tutup port 139 di firewall untuk SMB
Write-Output "Menutup port 139 di firewall untuk SMB..."
Get-NetFirewallRule -DisplayName "Allow SMB (TCP 139)" | Remove-NetFirewallRule

Write-Output "Layanan SMB telah dihentikan dan port firewall telah ditutup."
