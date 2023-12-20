# WGet-LLM-Hug
Status: Working

## Description
WGet-LLM-Hug is a PowerShell script complemented by Batch scripts, designed to simplify file downloads, specifically for, GGUF and GPTQ, HuggingFace model files, using the `wget` utility. It's tailored for users with limited internet access and older systems, supporting PowerShell 5 for Windows 7/8.1 compatibility, but also works on newer systems.

## Features:
- **Complex URL Reading**: Extracts filenames from HuggingFace URLs containing ".gguf" and ".gptq".
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
1. Copy WGet-LLM-Hug to its own folder, then run `Setup-Install.Bat`, this sets up, `wget.exe` and folders.
2. Create folder for model to download to, and put in it, config.json and the readme.md, from HuggingFace.
3. Partially download the model file, then cancel the download and copy the link it gave (it must be done like this).
4. Run `WGet-LLM-Hug.Bat`, select `Enter URL`from the menu, and paste the link, it will now download. 
5. When download is finished then move it from `.\Completed` to the model folder you made.

## Requirements
- Windows 7/8.1/10/11
- PowerShell 5-7.
- Internet connection.
- `wget.exe` through installer, supporting, x86, x64, ARM64.
- URL linked to a file with ".gguf" or ".gptq" format.

## Note
WGet-LLM-Hug is a simplified concept compared to "Downlord", WGet-LLM-Hug is focused on language models, where as Downlord is intended as a more general purpose downloader.

## Disclaimer
This program is provided "as is" without warranties or support. Users are responsible for the content they, download and use, as well as, any resulting damage to, hardware or sanity.
