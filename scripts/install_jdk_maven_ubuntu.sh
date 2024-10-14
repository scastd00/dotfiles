#!/bin/bash

# Update the package list
echo "Updating the package list..."
sudo apt update

# Install JDK 21 and Maven
echo "Downloading and installing JDK 21 and maven..."
sudo apt install openjdk-21-jdk maven -y

# Set the environment variables
echo "export JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64" >> ~/.profile

# Reload the profile
source ~/.profile

# Check the installed versions
echo "Checking the installed versions..."
java -version
mvn -version

# Print completion message in green
printf "\33[32m"
echo ""
echo "#####################################"
echo "JDK and Maven installation completed."
echo "#####################################"
echo ""
printf "\33[0m"
