# Powershell script to install JDK and Maven on Windows

# Go to the Downloads directory
cd $env:USERPROFILE\Downloads

# Install JDK 21
Write-Host "Downloading and installing JDK 21..."
Start-BitsTransfer -Source "https://download.oracle.com/java/21/latest/jdk-21_windows-x64_bin.exe" -Destination "jdk-21_windows-x64_bin.exe"
Start-Process -FilePath "jdk-21_windows-x64_bin.exe" -ArgumentList "/s" -Wait

# Install Maven
Write-Host "Downloading and installing Maven 3.9.9..."
Start-BitsTransfer -Source "https://dlcdn.apache.org/maven/maven-3/3.9.9/binaries/apache-maven-3.9.9-bin.zip" -Destination "apache-maven-3.9.9-bin.zip"
Expand-Archive -Path "apache-maven-3.9.9-bin.zip" -DestinationPath "C:\Program Files" -Force

# Set the environment variable for JDK in the system. Keep for every session even after reboot
[Environment]::SetEnvironmentVariable("JAVA_HOME", "C:\Program Files\Java\jdk-21", [System.EnvironmentVariableTarget]::Machine)

# Add JDK and Maven bin directories to the system PATH if they are not already present
$javaBin = "C:\Program Files\Java\jdk-21\bin"
$mavenBin = "C:\Program Files\apache-maven-3.9.9\bin"
if ($env:Path -notlike "*$javaBin*") {
    [Environment]::SetEnvironmentVariable("Path", "$env:Path;$javaBin", [System.EnvironmentVariableTarget]::Machine)
    Write-Host "Added $javaBin to the PATH"
}
if ($env:Path -notlike "*$mavenBin*") {
    [Environment]::SetEnvironmentVariable("Path", "$env:Path;$mavenBin", [System.EnvironmentVariableTarget]::Machine)
    Write-Host "Added $mavenBin to the PATH"
}

# Reload the environment variables
$env:Path = [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::Machine)

# Verify the installation
java --version
mvn --version

# Clean up the downloaded files
Remove-Item "jdk-21_windows-x64_bin.exe"
Remove-Item "apache-maven-3.9.9-bin.zip"

# Print completion message
Write-Host ""
Write-Host "#####################################"
Write-Host "JDK and Maven installation completed."
Write-Host "#####################################"
Write-Host ""
