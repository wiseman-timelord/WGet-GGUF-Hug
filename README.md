# WGet-GGUF-Hug
Status: Working
<br>The next update will include
- file automatically moved to the ".\completed" folder.
- the resuming of downloads will hopefully work.
- a installer/setup batch, including downloading of WGet and setup of folders.
- Small improvements and refinements.
- GPT4 magic (original was written in GPT3.5).

## Description
WGet-GGUF-Hug is a PowerShell script designed to simplify file downloads using the `wget` utility. It offers a straightforward interface for entering HuggingFace download URLs, extracting filenames, checking for existing files, and executing downloads. The script efficiently organizes downloaded files into "Downloads" and "Completed" folders, enhancing user experience within a PowerShell environment. This program is designed for Powershell 5 (windows 8.1 onwards), the idea is, you have, no internet and a dated laptop, but now you can still get language models on public wifi.

## Features:
- **Reading of Complex URLs**: WGet-GGUF-Hug extracts filenames from URLs containing ".gguf" in a specific format.
- **Download Method Selection**: WGet-GGUF-Hug uses the `wget.exe` utility for downloads.
- **File Management**: WGet-GGUF-Hug organizes downloaded files into "Downloads" and "Completed" folders.
- **Interactive Menus**: WGet-GGUF-Hug features a user-friendly menu system with options to enter a download URL, scan files in the "Downloads" or "Completed" folder, and exit the program.

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
1. Clone the repository or download the script.
2. Run the script using PowerShell: `powershell .\WGet-GGUF-Hug.ps1`.
3. Follow the on-screen prompts to initiate downloads, scan folders, or exit the program.

## Requirements
- PowerShell 5.1 or higher
- Internet connection
- `wget.exe` utility available in the system PATH
- URL linked to the file with ".gguf" format

## Note
This is a much simplified version of the concept of "Downlord", a robust downloader, however, HuggingFace broke for Downlord, and it became impossible to fix on gpt3.5, hence, WGet-GGUF-Hug has a specific purpose, and is able to be maintained with GPT 3.5, and its for the specific purpose I needed Downlord for, if you want it for some other format of file, then try, Downlord-Py or Downlord-Ps, or modify the scripts.

## Disclaimer
This program is provided "as is", and the creator, makes and produces, no, warranties and/or support. Users are solely responsible for the content they, download and use, and also any resulting damage to, hardware and/or sanity.

