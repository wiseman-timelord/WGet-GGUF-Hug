# Initialization
$Host.UI.RawUI.ForegroundColor = 'Yellow'
$Host.UI.RawUI.BackgroundColor = 'Black'

# Global variables
$global:downloadFolder = ".\temporary"
$global:completedFolder = ".\Completed"

# Create necessary folders
function Create-Folder($path) {
    $null = New-Item -ItemType Directory -Force -Path $path
}

# Start script message
function Start-Script {
    Write-Host "Starting WGet-LLM-Hug..."
    Start-Sleep -Seconds 2
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
                Write-Host "`nFilename Extracted: $filename" -ForegroundColor Green
                Start-Sleep -Seconds 2
                return $filename
            }
        }
    }

    Write-Host "Unable to extract filename from the URL." -ForegroundColor Red
    throw "Filename Extraction Failure!"
}

function Download {
    Write-Host ""
	$url = Read-Host "Enter URL"

    try {
        $filename = Extract-Filename -url $url

        Write-Host "`nFilename Extracted: $filename"

        $completedFilename = Join-Path $Script:completedFolder $filename
        $downloadPath = Join-Path $Script:downloadFolder $filename

        # Diagnostics: Print out the paths
        Write-Host "Download Path: $downloadPath"
        Write-Host "Completed File Path: $completedFilename"

        if (Test-Path $completedFilename) {
            Write-Host "Download of '$filename' already completed!"
            Start-Sleep -Seconds 2
        } else {
            if (Test-Path $downloadPath) {
                Write-Host "File '$filename' already exists in ${Script:downloadFolder}, starting new download..."
            } else {
                Write-Host "Downloading '$filename'..."
            }

            $downloadCommand = ".\libraries\wget.exe"
            $arguments = "--no-check-certificate", "-O", "`"$($downloadPath)`"", "$($url)"

            # Diagnostics: Print out the command and arguments
            Write-Host "Command to execute: $downloadCommand"
            Write-Host "Arguments: $($arguments -join ' ')"

            Start-Process -FilePath $downloadCommand -ArgumentList $arguments -Wait -NoNewWindow -PassThru | Out-String

            if ($LASTEXITCODE -eq 0) {
                Write-Host "Download of '$filename' success." -ForegroundColor Green
                Move-Item -Path $downloadPath -Destination $Script:completedFolder -Force
                Write-Host "Moved to ${Script:completedFolder} successfully." 
            } else {
                Write-Host "Download of '$filename' failed." -ForegroundColor Red
            }
        }
    } catch {
        Write-Host "Error: $_"
        Start-Sleep -Seconds 2
    }
}

function Scan-Folders {
    Write-Host "Scanning Folders..."

    function Scan-Directory($path, $folderName) {
        Write-Host "`n${folderName}:"
        $files = Get-ChildItem -Path $path -Include "*.gguf", "*.gptq" -Recurse
        if ($files.Count -eq 0) { Write-Host "No files in ${folderName}..." }
        else { $files | ForEach-Object { Write-Host "$($_.Name)" } }
    }

    Scan-Directory $Script:downloadFolder "temporary"
    Scan-Directory $Script:completedFolder "Completed"
    Start-Sleep -Seconds 2
}

function Empty-Temp {
    Write-Host "`nEmptying Temporary Folder..."
    Get-ChildItem -Path $Script:downloadFolder -Recurse | Remove-Item -Force
    Write-Host "...Temporary Folder Emptied.`n"
	Start-Sleep -Seconds 2
}

function Show-Menu {
    Clear-Host
	Write-Host "======================( WGET-LLM-HUG )======================"
    Write-Host "`n`n`n`n`n`n`n`n"
    Write-Host "                  1) Enter New Url`n"
    Write-Host "                  2) Scan Program Folders`n"
    Write-Host "                  3) Empty Temp Folder`n"
    Write-Host "                  0) Exit Program`n`n`n`n`n`n`n`n`n`n`n"
}

function Main {
    Start-Script
    Initialize-Folders

    do {
        Show-Menu
        $choice = Read-Host "Enter your choice"

        switch ($choice) {
            "0" { break }
            "1" { Download }
            "2" { Scan-Folders }
            "3" { Empty-Temp }
            default { Write-Host "Invalid choice. Try again." -ForegroundColor Red }
        }
    } while ($true)
}

Main