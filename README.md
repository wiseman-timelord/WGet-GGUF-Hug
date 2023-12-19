# WGet-GGUF-Hug
Status: Working
* This program has only been tested so far on "TheBloke/CodeUp-Llama-2-13B-Chat-HF-GGUF", this is currently being done as I write, and it is doing so splendidly onpublic wifi, however, resuming downloads is un-tested. This program will be further developed when I have, my own internet and access to GPT4, again.  

## Description
WGet-GGUF-Hug is a PowerShell script designed to simplify file downloads using the `wget` utility. It offers a straightforward interface for entering download URLs, extracting filenames, checking for existing files, and executing downloads. The script efficiently organizes downloaded files into "Downloads" and "Completed" folders, enhancing user experience within a PowerShell environment.

## Features:
- **Reading of Complex URLs**: WGet-GGUF-Hug extracts filenames from URLs containing ".gguf" in a specific format.
- **Download Method Selection**: WGet-GGUF-Hug uses the `wget.exe` utility for downloads.
- **File Management**: WGet-GGUF-Hug organizes downloaded files into "Downloads" and "Completed" folders.
- **Interactive Menus**: WGet-GGUF-Hug features a user-friendly menu system with options to enter a download URL, scan files in the "Downloads" or "Completed" folder, and exit the program.

## Interface:
```
                     -= WGet-GGUF-Hug =-

                1) Enter Download URL
                2) Scan Downloads Folder
                3) Scan Completed Folder
                0) Exit Program

Enter your choice:

```
```
Resolving cdn-lfs.huggingface.co (cdn-lfs.huggingface.co)...
 108.156.46.81, 108.156.46.127, 108.156.46.84, ...
Connecting to cdn-lfs.huggingface.co (cdn-lfs.huggingface.co
)|108.156.46.81|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 13831319424 (13G) [binary/octet-stream]
Saving to: 'C:/Programming/WGet-GGUF-Hug/WGet-GGUF-Hug v0p2/
Downloads/codeup-llama-2-13b-chat-hf.Q8_0.gguf'

oads/codeup-ll  38%[>    ]   4.99G  2.08MB/s    eta 64m 45s

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

