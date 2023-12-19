# WGet-LLM-Hug
Status: Working

## Description
WGet-LLM-Hug is a PowerShell script complemented by Batch scripts, designed to simplify file downloads, specifically for, GGUF and GPTQ, HuggingFace model files, using the `wget` utility. It's tailored for users with limited internet access and older systems, supporting PowerShell 5 for Windows 7/8.1 compatibility, but also works on newer systems.

## Features:
- **Complex URL Reading**: Extracts filenames from URLs containing ".gguf" and ".gptq" in a specific format.
- **Download Method Selection**: Utilizes `wget.exe` for downloads.
- **File Management**: Organizes files into "temporary", "Downloads", and "Completed" folders.
- **Interactive Menus**: Features user-friendly menu systems in both PowerShell and Batch scripts.
- **Installer Script**: Ensures the setup of required folders and downloads `wget.exe` if not present.
- **Launcher Script**: Provides an easy way to run the PowerShell script, especially for users unfamiliar with PowerShell commands.

## Interface:
```



                     -= WGet-LLM-Hug =-

                      1) Enter URL
                      2) Scan Folders
                      3) Empty Temp
                      0) Exit Program

Enter your choice:



```
```
Resolving cdn-lfs-us-1.huggingface.co (cdn-lfs-us-1.huggingf
ace.co)... 18.244.140.127, 18.244.140.29, 18.244.140.43, ...

Connecting to cdn-lfs-us-1.huggingface.co (cdn-lfs-us-1.hugg
ingface.co)|18.244.140.127|:443... connected.
WARNING: cannot verify cdn-lfs-us-1.huggingface.co's certifi
cate, issued by 'CN=Amazon RSA 2048 M01,O=Amazon,C=US':
  Unable to locally verify the issuer's authority.
HTTP request sent, awaiting response... 200 OK
Length: 7695857376 (7.2G) [binary/octet-stream]
Saving to: './temporary/una-cybertron-7b-v3-oma.Q8_0.gguf'

   ./temporary   0%[     ]   1.84M  51.1KB/s    eta 21h 32m

```

## Usage
1. Clone the repository or download the scripts.
2. Run the installer (setup batch script) to ensure `wget.exe` is installed and folders are set up.
3. Use the launcher script to start the PowerShell script.
4. Follow the on-screen prompts to initiate downloads, scan folders, or exit the program.

## Requirements
- Windows 7/8.1/10/11
- PowerShell 5.1 or higher.
- Internet connection.
- `wget.exe` installed and accessible (handled by the installer script).
- URL linked to a file with ".gguf" or ".gptq" format.

## Note
WGet-LLM-Hug, a simplified concept compared to "Downlord", is focused on functionality and ease of maintenance, catering to specific download needs with a user-friendly approach.

## Disclaimer
This program is provided "as is" without warranties or support. Users are responsible for the content they download and use, and any resulting damage to hardware or sanity.
