# Prompt the user to enter the subnet or network
$subnet = Read-Host "Enter the subnet or network (e.g., 192.168.1):"

# Create the script content
$scriptContent = @"
# Function to check if a host is reachable using ICMP ping
function Test-HostReachability {
    param(
        [Parameter(Mandatory=$true)]
        [string]$IPAddress
    )

    $ping = New-Object System.Net.NetworkInformation.Ping
    $result = $ping.Send($IPAddress)

    if ($result.Status -eq 'Success') {
        return $true
    } else {
        return $false
    }
}

# Define the IP address range to scan
`$subnet = '$subnet'

# Iterate through IP addresses in the subnet range
for (`$i = 1; `$i -le 255; `$i++) {
    `$ip = "`$subnet.`$i"

    # Check if the IP address is reachable
    `$reachable = Test-HostReachability -IPAddress `$ip

    if (`$reachable) {
        Write-Host "Host found: `$ip"
    }
}
"@

# Save the script as network_scanner.ps1
$scriptContent | Out-File -FilePath "network_scanner.ps1"

Write-Host "Script generated and saved as network_scanner.ps1."
