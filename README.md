# WGetLlmHug-Psc
Status: Development (O_o/'
<br> Work planned for next release...
- Retry download works splendid, but the download function is now broken also.
- Testing of download, to see if will move to completed folder.
- Better display when downloading a model, what options are available, and how can we best visualize the information on a single download...lets make it epic, even if it could potentially defeat some robustness, we want it to look COOL...
  
## Description
WGetLlmHug-Psc is a PowerShell script complemented by Batch scripts, designed to simplify file downloads, specifically for, GGUF and GPTQ, HuggingFace model files, using the `wget` utility. It's tailored for users with limited internet access and older systems, supporting PowerShell 5 for Windows 7/8.1 compatibility, but also works on newer systems, either way for such purposes it is a, robust and optimised, tool.

## Features:
- **Complex URL Reading**: Extracts filenames from HuggingFace URLs containing ".gguf" and ".gptq".
- **Download Method Selection**: Utilizes `wget.exe` for downloads.
- **File Management**: Organizes files into "temporary", "Downloads", and "Completed" folders.
- **Interactive Menus**: Features user-friendly menu systems in both PowerShell and Batch scripts.
- **Installer Script**: Ensures the setup of required folders and downloads `wget.exe` if not present.
- **Launcher Script**: Provides an easy way to run the PowerShell script, especially for users unfamiliar with PowerShell commands.

## Interface:
```

=====================( WGetLmmHug-Psc )======================


                   1. Download A Model,
                   2. Scan Folders,

                   0. Exit Program.


\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/

Enter Your Choice:
















```
```
--2023-12-20 13:34:23--  https://cdn-lfs-us-1.huggingface.co
/repos/52/79/5279038ee7db94f4d3fe0026f9ec759ac5211a30aad8ee7
5fd69a470306e8c7f/cbfc52efd83d35ed194f0f33bb588fc6f7bd17b98e
f62ba4e3af13e21e833dd1?response-content-disposition=attachme
nt%3B+filename*%3DUTF-8''quantum-dpo-v0.1.Q8_0.gguf%3B+filen
ame%3D%22quantum-dpo-v0.1.Q8_0.gguf%22%3B&Expires=1703338396
&Policy=eyJTdGF0ZW1lbnQiOlt7IkNvbmRpdGlvbiI6eyJEYXRlTGVzc1Ro
YW4iOnsiQVdTOkVwb2NoVGltZSI6MTcwMzMzODM5Nn19LCJSZXNvdXJjZSI6
Imh0dHBzOi8vY2RuLWxmcy11cy0xLmh1Z2dpbmdmYWNlLmNvL3JlcG9zLzUy
Lzc5LzUyNzkwMzhlZTdkYjk0ZjRkM2ZlMDAyNmY5ZWM3NTlhYzUyMTFhMzBh
YWQ4ZWU3NWZkNjlhNDcwMzA2ZThjN2YvY2JmYzUyZWZkODNkMzVlZDE5NGYw
ZjMzYmI1ODhmYzZmN2JkMTdiOThlZjYyYmE0ZTNhZjEzZTIxZTgzM2RkMT9y
ZXNwb25zZS1jb250ZW50LWRpc3Bvc2l0aW9uPSoifV19&Signature=Z2Xv6
7Eb6QyiFHP1R-MQyiOj6u8Jd42SOX5J5pneGO9H624EOmMD0enBkCfqN9pvB
91ndo6ymJQtGXCIeV18vUpWVu~AWDY2hYgFM2bwSWFYga9nFQznve62I1C1r
D33OKIKPp33Gg3pNbq8iaxTPLt2RC-61vcOMquW1u5gvutCTV-f6LAUFfGdG
P7WVFe34xevc8uZyydGccKHN6fXIY5CnelH0UWJmkC3bI8qNBRolaCTNyuHs
XTAUBjJJm4Xe15kNnaT-C00Kj~p4LfksSYJB2VwuZNNSdN7S4jbhUqY3fwxy
KrB0nnG5atZiD2gM8jT-VEe7gg-NA~4reO1jw__&Key-Pair-Id=KCD77M1F
0VK2B
Resolving cdn-lfs-us-1.huggingface.co (cdn-lfs-us-1.huggingf
ace.co)... 18.244.140.29, 18.244.140.43, 18.244.140.108, ...

Connecting to cdn-lfs-us-1.huggingface.co (cdn-lfs-us-1.hugg
ingface.co)|18.244.140.29|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 7696793728 (7.2G) [binary/octet-stream]
Saving to: './temporary/quantum-dpo-v0.1.Q8_0.gguf'

emporary/quant  38%[>    ]   2.77G  1.49MB/s    eta 58m 57s

```

## Usage
1. Copy WGetLlmHug-Psc to its own folder, then run `Setup-Install.Bat`, this sets up, `wget.exe` and folders.
2. Create folder for model to download to, and put in it, config.json and the readme.md, from HuggingFace.
3. Partially download the model file, then cancel the download and copy the link it gave (it must be done like this).
4. Run `WGetLlmHug-Psc.Bat`, select `Enter URL`from the menu, and paste the link, it will now download. 
5. When download is finished then move it from `.\Completed` to the model folder you made.

## Requirements
- Windows 7/8.1/10/11
- PowerShell 5-7.
- Internet connection.
- `wget.exe` through installer, supporting, x86, x64, ARM64.
- URL linked to a file with ".gguf" or ".gptq" format.

## Note
WGetLlmHug-Psc is a simplified concept compared to "Downlord", WGetLlmHug-Psc is focused on language models, where as Downlord is intended as a more general purpose downloader.

## Disclaimer
This program is provided "as is" without warranties or support. Users are responsible for the content they, download and use, as well as, any resulting damage to, hardware or sanity.
