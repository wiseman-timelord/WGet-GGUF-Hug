# Initialization
$Host.UI.RawUI.ForegroundColor = 'Yellow'
$Host.UI.RawUI.BackgroundColor = 'Black'

# Global variables
$global:downloadFolder = ".\cache"
$global:completedFolder = ".\Completed"
$global:librariesFolder = ".\libraries"
$global:retryLimit = 9


# Start script message
function Start-Script {
    Write-Host "...WGetLlmHug-Psc Has Started!"
}

# Artwork
function PrintHeader {
	Clear-Host
	Write-Host "`n====================( " -NoNewline -ForegroundColor Cyan
    Write-Host "WGetLmmHug-Psc" -NoNewline -ForegroundColor Yellow
    Write-Host " )======================`n" -ForegroundColor Cyan
}

# Maintenance
function Perform-Maintenance {
    Write-Host "`nFolder Maintenance Started..."
    $directories = @($Script:downloadFolder, $Script:completedFolder)

    foreach ($dir in $directories) {
        $zeroByteFiles = Get-ChildItem -Path $dir -Recurse | Where-Object { $_.Length -eq 0 }
        foreach ($file in $zeroByteFiles) {
            Remove-Item $file.FullName -Force
            Write-Host "...Deleted 0MB File: $($file.Name)." -ForegroundColor Red
        }
    }
	Write-Host "...Folder Maintenance Complete."
}



function Extract-Filename {
    param ([string]$url)

    # Handle both .gguf and .gptq file formats
    $ggufIndex = $url.IndexOf(".gguf")
    $gptqIndex = $url.IndexOf(".gptq")

    foreach ($index in @($ggufIndex, $gptqIndex)) {
        if ($index -ge 0) {
            $percentIndex = $url.LastIndexOf("%", $index)
            if ($percentIndex -ge 0) {
                $startIndex = $percentIndex + 3
                $filename = $url.Substring($startIndex, $index - $startIndex + 5)
                Write-Host "`nFilename Extracted: $filename`n" -ForegroundColor Green
                return $filename
            }
        }
    }
}

function Download {
    $url = Read-Host "`nEnter Your URL"
    try {
        $filename = Extract-Filename -url $url
        $completedPath = Join-Path $global:completedFolder $filename
        $tempPath = Join-Path $global:downloadFolder $filename

        if (Test-Path $completedPath) { 
            Write-Host "Download Already Complete..."; 
            Write-Host "...Location Is: '.\Completed'.`n"; 
            return 
        }

        $resumeDownload = $false
        $existingFile = Get-Item $tempPath -ErrorAction SilentlyContinue
        if ($null -ne $existingFile) {
            if ($existingFile.Length -eq 0) {
                Write-Host "Deleting 0MB File: $filename" -ForegroundColor Yellow
                Remove-Item $tempPath -Force
            } elseif ($existingFile.Length -gt 1MB) {
                Write-Host "Resuming Download for $filename" -ForegroundColor Cyan
                $resumeDownload = $true
            }
        }

        for ($i = 0; $i -lt $global:retryLimit; $i++) {
            Write-Host "Attempt $(($i + 1))"
            try {
                $downloadCommand = ".\libraries\wget.exe"
                $arguments = if ($resumeDownload) { "-c" } else { "" }, "--no-check-certificate", "-O", $tempPath, $url

                Start-Process -FilePath $downloadCommand -ArgumentList $arguments -Wait -NoNewWindow -PassThru | Out-String

                if ($LASTEXITCODE -eq 0) {
                    if (Test-Path $tempPath) {
                        $fileInfo = Get-Item $tempPath
                        if ($fileInfo.Length -gt 0) {
                            Move-Item $tempPath $Script:completedFolder -Force
                            Write-Host "File Download Success!" -ForegroundColor Green
                            return
                        } else {
                            Write-Host "Incomplete Download... 0MB File Found" -ForegroundColor Yellow
                            Remove-Item $tempPath -Force
                        }
                    }
                } else {
                    Write-Host "...Download Attempt Failed." -ForegroundColor Red
                }

                Write-Host "Retrying In 2 Seconds..."
                Start-Sleep -Seconds 2
            } catch {
                Write-Host "Error: $_" -ForegroundColor Red
                Write-Host "Retrying In 2 Seconds..."
                Start-Sleep -Seconds 2
            }
        }

        Write-Host "Retried $global:retryLimit Times..."
        Write-Host "...Re-Copy URL Try Again."
        Write-Host "Cleaning Up Cache..."
        Start-Sleep -Seconds 2

        if (Test-Path $tempPath -and (Get-Item $tempPath).Length -eq 0) {
            Remove-Item $tempPath -Force
            Write-Host "...0MB File Deleted."
        } else {
            Write-Host "...No File Present."
        }

    } catch {
        Write-Host "Error: $_" -ForegroundColor Red
    }
}

function Scan-Folders {
    PrintHeader
    Write-Host "Results From Scanning..."

    function Scan-Directory($path, $folderName) {
        Write-Host "`n${folderName}:"
        $files = Get-ChildItem -Path $path -Include "*.gguf", "*.gptq" -Recurse -ErrorAction SilentlyContinue
        Write-Host ($files.Count -gt 0 ? ($files | ForEach-Object { $_.Name }) : "No files in $folderName...")
        return $files
    }

    $tempFiles = Scan-Directory $Script:downloadFolder "cache"
    Scan-Directory $Script:completedFolder "Completed"

    if ($tempFiles.Count -gt 0) {
        $userChoice = Read-Host "Select, 'E' To Empty Cache Or '0' For Menu: "
        switch ($userChoice) {
            "e" { Empty-Temp }
            "0" { } # Do nothing, return to menu
            default { Write-Host "`nInvalid choice. Try again." -ForegroundColor Red }
        }
    } else {
        Write-Host "`n`nCache Empty, Select '0' For Menu: "
        while (($userChoice = Read-Host) -ne "0") {
            Write-Host "`nInvalid choice..." -ForegroundColor Red
        }
    }
}

function Empty-Temp {
    Write-Host "`nEmptying Cache Folder..."
    Get-ChildItem -Path $Script:downloadFolder -Recurse | Remove-Item -Force
    Write-Host "...Cache Folder Emptied.`n"
}

function Check-WGet {
    PrintHeader
    $wgetPath = Join-Path $global:librariesFolder "wget.exe"

    if (Test-Path $wgetPath) {
        $sigcheckOutput = & (Join-Path $global:librariesFolder "sigcheck.exe") -nobanner -a $wgetPath
        $architecture = if ($sigcheckOutput -match '32-bit') { 'x32' } 
                        elseif ($sigcheckOutput -match '64-bit') { 'x64' } 
                        elseif ($sigcheckOutput -match 'ARM') { 'ARM' } 
                        else { 'Unknown' }
        Write-Host "WGet Architecture: $architecture`n" -ForegroundColor Green
    } else {
        Write-Host "WGet executable not found at $wgetPath" -ForegroundColor Red
    }

    Write-Host " Select '0' For Menu: "
    while (($userChoice = Read-Host) -ne "0") {
        Write-Host "Invalid choice." -ForegroundColor Red
    }
}

function Show-Menu {
    Start-Sleep -Seconds 10 #-- 10 for debug & 2 for normal
	Clear-Host
    PrintHeader
    Write-Host "                   1. Download A Model,"
    Write-Host "                   2. Scan Folders,"
	Write-Host "                   3. Analyse WGet.Exe,`n"
    Write-Host "                   0. Exit Program.`n"
}

function Main {
    Start-Script
    Perform-Maintenance
	
    do {
        Show-Menu
        $choice = Read-Host "Select, Options '1-3' Or '0' To Exit"

        switch ($choice) {
            "0" { exit }
            "1" { Download }
            "2" { Scan-Folders }
            "3" { Check-WGet }
            default { Write-Host "Invalid choice..." -ForegroundColor Red }
        }
    } while ($true)
}

Main


