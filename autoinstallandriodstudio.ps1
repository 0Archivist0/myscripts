param(
    [string]$url,
    [string]$filename,
    [string]$download_path
)

# Check parameters
if ($url -eq "") {
    Write-Error "Please specify the URL to the Android Studio installer."
    exit 1
}

if ($filename -eq "") {
    Write-Error "Please specify the filename of the Android Studio installer."
    exit 1
}

if ($download_path -eq "") {
    $download_path = "$env:HOME\Downloads\$filename"
}

# Download Android Studio
Write-Host "Downloading Android Studio..."
try {
    # Download the installer
    Invoke-WebRequest -Uri $url -OutFile $download_path -ErrorAction Stop
} catch {
    Write-Error "Failed to download Android Studio. Please check the URL and try again."
    exit 1
}

# Install Android Studio
Write-Host "Installing Android Studio..."
try {
    # Start the installer
    Start-Process $download_path -Wait -ErrorAction Stop
} catch {
    Write-Error "Failed to install Android Studio. Please make sure the download path is correct and try again."
    exit 1
}

# Wait for Android Studio to launch
Write-Host "Waiting for Android Studio to launch..."
$retry_count = 0
$max_retries = 10
do {
    Start-Sleep -Seconds 1
    $retry_count++
} until ((Get-Process "studio64" -ErrorAction SilentlyContinue) -or ($retry_count -eq $max_retries))

if ($retry_count -eq $max_retries) {
    Write-Error "Failed to launch Android Studio. Please check your installation and try again."
    exit 1
}

# Wait for Android Studio to finish initialization
Write-Host "Waiting for Android Studio to initialize..."
$retry_count = 0
$max_retries = 60
do {
    Start-Sleep -Seconds 1
    $retry_count++
} until ((Get-Process "studio64" -ErrorAction SilentlyContinue).Responding -or ($retry_count -eq $max_retries))

if ($retry_count -eq $max_retries) {
    Write-Error "Failed to initialize Android Studio. Please check your installation and try again."
    exit 1
}

# Exit cleanly
Write-Host "Android Studio has been installed successfully."
exit 0
