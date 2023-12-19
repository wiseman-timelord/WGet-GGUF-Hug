# WGet-GGUF-Hug
WGet-GGUF-Hug is a PowerShell script designed to provide a simple interface for downloading files using the `wget` utility. It allows users to enter download URLs, extracts filenames, checks for existing files, and performs downloads. The script organizes downloaded files into "Downloads" and "Completed" folders. The program features a user-friendly menu system and informative status messages. Users can interact with the script to initiate downloads, view files in the "Downloads" or "Completed" folders, and exit the program. WGet-GGUF-Hug streamlines the download process and enhances user experience within a PowerShell environment.


**Features and Functions of WGet-GGUF-Hug:**

1. **Start-Script:**
   - Displays a startup message when the script begins.

2. **Initialize-Folders:**
   - Creates necessary folders, such as "Downloads" and "Completed," and sets initial folders.

3. **Extract-Filename:**
   - Extracts the filename from a given URL that contains ".gguf" in a specific format.
   - Displays the extracted filename.
   - Pauses for 2 seconds for visibility.

4. **Show-Menu:**
   - Clears the console and displays a menu for user interaction.

5. **Download:**
   - Accepts a URL from the user.
   - Extracts the filename from the URL.
   - Displays the extracted filename.
   - Checks if the file already exists in the "Downloads" or "Completed" folder.
   - Downloads the file using `wget.exe` and specifies the output file.
   - Displays the output of the `wget` command.
   - Moves the downloaded file to the "Completed" folder upon successful download.
   - Provides status messages for successful or failed downloads.

6. **Scan-Folder:**
   - Displays a list of files in the specified folder (either "Downloads" or "Completed").

7. **Main:**
   - Initiates the main program loop.
   - Displays the startup message, initializes folders, and presents a menu for user choices.
   - Allows the user to:
     - Enter a download URL.
     - Scan files in the "Downloads" folder.
     - Scan files in the "Completed" folder.
     - Exit the program.
   - Handles invalid choices gracefully.



```

                     -= WGet-GGUF-Hug =-

                1) Enter Download URL
                2) Scan Downloads Folder
                3) Scan Completed Folder
                0) Exit Program

Enter your choice:

```
