# Define the Python version and installation parameters
$PythonVersion = "3.9.7"
$InstallPath = "C:\Python$PythonVersion"
$DownloadUrl = "https://www.python.org/ftp/python/$PythonVersion/python-$PythonVersion-amd64.exe"
$InstallArgs = "/quiet InstallAllUsers=1 PrependPath=1"

# Set up error handling and logging
$ErrorActionPreference = "Stop"
$LogFile = Join-Path $env:TEMP "install_python.log"
$LogFileStream = [System.IO.StreamWriter]::new($LogFile, $true)

try {
    # Check if Python is already installed
    if (Test-Path $InstallPath) {
        Write-Output "Python $PythonVersion is already installed."
        exit 0
    }

    # Check if the DownloadUrl variable is not empty
    if ([string]::IsNullOrEmpty($DownloadUrl)) {
        throw "The DownloadUrl variable is empty."
    }

    # Download the Python installer
    Write-Output "Downloading Python $PythonVersion..."
    $InstallerPath = Join-Path $env:TEMP "python-$PythonVersion.exe"
    Invoke-WebRequest -Uri $DownloadUrl -OutFile $InstallerPath

    # Install Python using the downloaded installer
    Write-Output "Installing Python $PythonVersion..."
    Start-Process -FilePath $InstallerPath -ArgumentList $InstallArgs -Wait

    # Add Python to the system PATH environment variable
    Write-Output "Adding Python to the system PATH..."
    $env:Path = "$InstallPath;$env:Path"

    # Verify the installation
    Write-Output "Python installation complete."
    python --version
    pip --version
}
catch {
    # Log any errors to the log file
    $LogFileStream.WriteLine("Error: $($_.Exception.Message)")
    $LogFileStream.Flush()

    # Write the error message to the console
    Write-Error $_

    # Clean exit with error code
    exit 1
}
finally {
    # Close the log file
    $LogFileStream.Close()
}

# Clean exit with success code
exit 0
