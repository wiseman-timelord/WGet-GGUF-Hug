# Set up global variables
$Script:currentFolder = $null
$Script:completedFolder = $null

function Start-Script {
    Write-Host "Starting WGet-GGUF-Hug..."
    Start-Sleep -Seconds 1
}

function Initialize-Folders {
    # Create necessary folders and set initial folders
    $Script:currentFolder = Join-Path $PSScriptRoot "Downloads"
    $Script:completedFolder = Join-Path $PSScriptRoot "Completed"
    $null = New-Item -ItemType Directory -Force -Path $Script:currentFolder
    $null = New-Item -ItemType Directory -Force -Path $Script:completedFolder
}

function Extract-Filename {
    param (
        [string]$url
    )

    # Find the index of ".gguf"
    $ggufIndex = $url.IndexOf(".gguf")

    if ($ggufIndex -ge 0) {
        # Work back to the previous "%"
        $percentIndex = $url.LastIndexOf("%", $ggufIndex)

        if ($percentIndex -ge 0) {
            # Count two characters after the "%"
            $startIndex = $percentIndex + 3
            $filename = $url.Substring($startIndex, $ggufIndex - $startIndex + 5)
			Write-Host "`nFilename Extracted: $filename"
			Start-Sleep -Seconds 2
            return $filename
        }
    }

    throw "Unable to extract filename from the URL."
}

function Show-Menu {
    Clear-Host
    Write-Host "`n                     -= WGet-GGUF-Hug =-`n"
    Write-Host "                1) Enter Download URL"
    Write-Host "                2) Scan Downloads Folder"
    Write-Host "                3) Scan Completed Folder"
    Write-Host "                0) Exit Program`n"
}

function Download {
    $url = Read-Host "Enter URL"

    try {
        $filename = Extract-Filename -url $url

        Write-Host "`nFilename Extracted: $filename"

        $completedFilename = Join-Path $Script:completedFolder $filename
        $downloadPath = Join-Path $Script:currentFolder $filename

        if (Test-Path $downloadPath) {
            Write-Host "File '$filename' already exists in $Script:currentFolder..."
            Start-Sleep -Seconds 2
        } elseif (Test-Path $completedFilename) {
            Write-Host "Download of '$filename' already completed!"
            Start-Sleep -Seconds 2
        } else {
            Write-Host "Downloading '$filename'..."

            # Construct the full path for the download file
            $downloadPath = Join-Path $Script:currentFolder $filename

            # Use Start-Process to run wget, specifying the output file
            $downloadCommand = "wget.exe"
            $arguments = "-O", "`"$($downloadPath)`"", "$($url)"

            # Capture the output of the wget command
            $output = Start-Process -FilePath $downloadCommand -ArgumentList $arguments -Wait -NoNewWindow -PassThru | Out-String

            Write-Host "wget Output: $($output)"

            if ($LASTEXITCODE -eq 0) {
                Write-Host "Download of '$filename' completed successfully."
                Move-Item -Path $downloadPath -Destination $Script:completedFolder -Force
                Write-Host "Move to $Script:completedFolder completed successfully."
            } else {
                Write-Host "Download of '$filename' failed."
            }
        }
    } catch {
        Write-Host "Error: $_"
        Start-Sleep -Seconds 30
    }
}



function Scan-Folder {
    Write-Host "Scanning $Script:currentFolder Folder..."
    $files = Get-ChildItem -Path $Script:currentFolder -Filter *.gguf

    if ($files.Count -eq 0) {
        Write-Host "No files in $Script:currentFolder..."
    } else {
        $files | ForEach-Object { Write-Host "$($_.Name)" }
    }

    Start-Sleep -Seconds 2
}

function Main {
    Start-Script
    Initialize-Folders

    do {
        Show-Menu
        $choice = Read-Host "Enter your choice"

        switch ($choice) {
            0 { return }
            1 { Download }
            2 { $Script:currentFolder = Join-Path $PSScriptRoot "Downloads"; Scan-Folder }
            3 { $Script:currentFolder = Join-Path $PSScriptRoot "Completed"; Scan-Folder }
            default { Write-Host "Invalid choice. Try again." }
        }
    } while ($true)
}

Main