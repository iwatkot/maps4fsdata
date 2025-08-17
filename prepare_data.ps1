# PowerShell script for maps4FS Data Preparation

# Stop script on any error
$ErrorActionPreference = "Stop"

$CWD = Get-Location
$DATA_DIR = Join-Path $CWD "data"

Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "           maps4FS Data Preparation Startup             " -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "Current working directory: $CWD" -ForegroundColor White
Write-Host "------------------------------------------------------------" -ForegroundColor Yellow

# Create data directory
if (!(Test-Path -Path $DATA_DIR)) {
    Write-Host "Creating data directory at $DATA_DIR" -ForegroundColor Green
    New-Item -ItemType Directory -Path $DATA_DIR -Force | Out-Null
} else {
    Write-Host "Data directory already exists at $DATA_DIR" -ForegroundColor Yellow
    Write-Host "All content will be removed from existing data directory." -ForegroundColor Yellow
    Get-ChildItem -Path $DATA_DIR -Force | Remove-Item -Recurse -Force
    Write-Host "Cleared existing content in data directory." -ForegroundColor Green
}

Write-Host "------------------------------------------------------------" -ForegroundColor Yellow

# Find all directories starting with "fs" in current directory
$fsDirs = Get-ChildItem -Path $CWD -Directory | Where-Object { $_.Name -like "fs*" }

foreach ($dir in $fsDirs) {
    $dirName = $dir.Name
    $dirPath = $dir.FullName
    Write-Host "--- Processing directory: $dirName" -ForegroundColor Magenta

    # Copy all files (not directories) from DIR to data directory
    $files = Get-ChildItem -Path $dirPath -File
    foreach ($file in $files) {
        Write-Host "Copying file $($file.Name) to data directory" -ForegroundColor White
        Copy-Item -Path $file.FullName -Destination $DATA_DIR
    }
    Write-Host "Copied files from $dirName directory" -ForegroundColor Green
    Write-Host "------------------------------------------------------------" -ForegroundColor Yellow

    # Iterate over subdirectories
    $subDirs = Get-ChildItem -Path $dirPath -Directory
    foreach ($subDir in $subDirs) {
        $subDirName = $subDir.Name
        $subDirPath = $subDir.FullName
        $zipFile = Join-Path $DATA_DIR "$subDirName.zip"
        Write-Host "Packing contents of $subDirName into $zipFile" -ForegroundColor White
        
        # Create zip archive of subdirectory contents
        Compress-Archive -Path "$subDirPath\*" -DestinationPath $zipFile -Force
    }
    Write-Host "------------------------------------------------------------" -ForegroundColor Yellow
    Write-Host "Packed subdirectories from $dirName directory" -ForegroundColor Green
    Write-Host "-------------- Directory $dirName processed. ---------------" -ForegroundColor Green
    Write-Host "------------------------------------------------------------" -ForegroundColor Yellow
}

Write-Host "Data preparation complete." -ForegroundColor Green
Write-Host "============================================================" -ForegroundColor Cyan
