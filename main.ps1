# Initialization
$Host.UI.RawUI.ForegroundColor = 'Yellow'
$Host.UI.RawUI.BackgroundColor = 'Black'

# Artwork
function PrintHeader {
	Clear-Host
	Write-Host "`n=====================( " -NoNewline -ForegroundColor Cyan
    Write-Host "WGetLmmHug-Psc" -NoNewline -ForegroundColor Yellow
    Write-Host " )======================`n" -ForegroundColor Cyan
}

function PrintSeparator {
	Write-Host "`n`n\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/" -ForegroundColor Cyan
}

# Global variables
$global:downloadFolder = ".\temporary"
$global:completedFolder = ".\Completed"
$global:retryLimit = 9

# Create necessary folders
function Create-Folder($path) {
    $null = New-Item -ItemType Directory -Force -Path $path
}

# Start script message
function Start-Script {
    Write-Host "...WGetLlmHug-Psc Has Started!"
}

# Initialize folders
function Initialize-Folders {
    Create-Folder $global:downloadFolder
    Create-Folder $global:completedFolder
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
        $completedPath = Join-Path $Script:completedFolder $filename
        $tempPath = Join-Path $Script:downloadFolder $filename

        if (Test-Path $completedPath) { 
            Write-Host "Download Already Complete..."; 
            Write-Host "...Location Is: '.\Completed'.`n"; 
            return 
        }
        if (Test-Path $tempPath) { 
            Write-Host "Download, Complete And Misplaced..."; 
            Write-Host "...Moved To '.\Completed'.`n";  
            return 
        }

        for ($i = 0; $i -lt $global:retryLimit; $i++) {
            Write-Host "Attempt $(($i + 1))"
            try {
                $downloadCommand = ".\libraries\wget.exe"
                $arguments = "-c", "--no-check-certificate", "-O", "`"$tempPath`"", "`"$url`""

                Start-Process -FilePath $downloadCommand -ArgumentList $arguments -Wait -NoNewWindow -PassThru | Out-String

                if ($LASTEXITCODE -eq 0) {
                    if (Test-Path $tempPath) {
                        $fileInfo = Get-Item $tempPath
                        if ($fileInfo.Length -ge 1MB) {
                            Move-Item $tempPath $Script:completedFolder -Force
                            Write-Host "File Download Success!" -ForegroundColor Green
                            return
                        } else {
                            Write-Host "Incomplete Download..." -ForegroundColor Yellow
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
        Write-Host "Cleaning Up Temporary..."
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

    $tempFiles = Scan-Directory $Script:downloadFolder "temporary"
    Scan-Directory $Script:completedFolder "Completed"
    PrintSeparator

    if ($tempFiles.Count -gt 0) {
        $userChoice = Read-Host "Enter, E To Empty Temporary Or 0 For Main Menu"
        switch ($userChoice) {
            "e" { Empty-Temp }
            "0" { } # Do nothing, return to menu
            default { Write-Host "`nInvalid choice. Try again." -ForegroundColor Red }
        }
    } else {
        Write-Host "No files to delete. Enter '0' For Main Menu"
        while (($userChoice = Read-Host) -ne "0") {
            Write-Host "`nInvalid choice..." -ForegroundColor Red
        }
    }
}

function Empty-Temp {
    Write-Host "`nEmptying Temporary Folder..."
    Get-ChildItem -Path $Script:downloadFolder -Recurse | Remove-Item -Force
    Write-Host "...Temporary Folder Emptied.`n"
}

function Show-Menu {
    Start-Sleep -Seconds 10 #-- 10 for debug & 2 for normal
	Clear-Host
    PrintHeader
    Write-Host "                     1. Download A Model,"
    Write-Host "                     2. Scan Folders,`n"
    Write-Host "                     0. Exit Program."
	PrintSeparator
}

function Main {
    Start-Script
    Initialize-Folders

    do {
        Show-Menu
        $choice = Read-Host "Enter Your Choice"

        switch ($choice) {
            "0" { exit }
            "1" { Download }
            "2" { Scan-Folders }
            default { Write-Host "Invalid choice..." -ForegroundColor Red }
        }
    } while ($true)
}

Main



