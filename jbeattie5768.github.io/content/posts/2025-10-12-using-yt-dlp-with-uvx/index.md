+++
date = '2025-10-12'
draft = true
title = 'Using YT-DLP With UVX'
tags = ["UV", "UVX", "yt-dlp"]
+++

## YT-DLP and Me

[YT-DLP](https://github.com/yt-dlp/yt-dlp) is a command-line audio/video downloader written in Python.  
I use it to extract audio from YouTube videos, which I listen to on my walks.

## UVX and YT-DLP

Thanks to the power of [UV](https://docs.astral.sh/uv/), you can run tools like YT-DLP without having to install them. UV caches the tool rather than installing (_sort of_), and since YT-DLP changes frequently, this is ideal and easy to use with the inbuilt UV alias `uvx` (equivalent to `uv tool run`).

## UVX Commands

These are what I use to extract the audio from YouTube videos. You will be able to modify for your needs:

```pwsh
# PowerShell
# Setup some Aliases for this Example
$YouTubeUrl  = "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
$OutFilename = "RickRoll.mp3"
$AudioFormat = "mp3"
$TempFolder  = "c:\temp\yt-dlp"  # My temp store before I copy to Phone/MP3 player
$FFmpegPath  = join-path -path $TempFolder -childpath "\ffmpeg-master-latest-win64-gpl\bin"  # Required binaries for audio extraction

cd $TempFolder  # Go to my temp store

# Run YT-DLP via UVX
uvx --no-cache yt-dlp -x --audio-format $AudioFormat --ffmpeg-location $FFmpegPath -o $OutFilename $YouTubeUrl --verbose
```

```pwsh
# Command breakdown 
uvx --no-cache yt-dlp         # Get the latest yt-dlp every time
-x                            # Extract audio (video discarded automatically)
                              # (Use -k to keep the intermediate video)
--audio-format $AudioFormat   # Use the specified audio format 
--ffmpeg-location $FFmpegPath # Location of FFMPEG binary: exe path or just dir
-o $OutFilename               # Output filename
$YouTubeUrl                   # YouTube URL
--verbose                     # Optional: print debugging information
```

The audio extraction requires the FFMPEG binaries which can be [downloaded from here](https://github.com/yt-dlp/FFmpeg-Builds). Simply extract to somewhere convenient.

---

### Making It Simple For Me

As a PowerShell script:

```pwsh
# Powershell Script, e.g. download_yt_audio.ps1
# Defaults
$DefaultFFmpegPath  = "C:\temp\yt-dlp\ffmpeg-master-latest-win64-gpl\bin"
$DefaultAudioFormat = "mp3"
$DefaultRootFolder  = "c:\temp\yt-dlp"  # My temp store
$DefaultAutoPlay    = "n"

# User Input
$YouTubeUrl  = Read-Host 'YouTube URL'
$AudioFormat = Read-Host 'Audio Format (default' $DefaultAudioFormat')'
$Filename    = Read-Host 'Output Filename (no extension)'
$FFmpegPath  = Read-Host 'FFMPEG Folder (default' $DefaultFFmpegPath')'
$RootFolder  = Read-Host 'Root Folder (default' $DefaultRootFolder')'
$AutoPlay    = Read-Host 'AutoPlay after download? (y/n) (default' $DefaultAutoPlay')'

# Check user inputs, use defaults if input empty
if (-not($FFmpegPath))  { $FFmpegPath  = "$DefaultFFmpegPath"}
if (-not($AudioFormat)) { $AudioFormat = "$DefaultAudioFormat"}
if (-not($RootFolder))  { $RootFolder  = "$DefaultRootFolder"}
if (-not($AutoPlay))    { $AutoPlay    = "$DefaultAutoPlay"}

$OutFilename = "$Filename.$AudioFormat"  # Extension added

Set-Location $RootFolder  # cd to root folder

# Run YT-DLP via UVX
uvx --no-cache yt-dlp -x --audio-format $AudioFormat --ffmpeg-location $FFmpegPath -o $OutFilename $YouTubeUrl --verbose

# Conditional: Play the downloaded file (Windows 10/11)
if ($AutoPlay -eq 'y') {
    $OutfilePath = join-path -path $RootFolder -childpath $OutFilename
    Start-Process -FilePath $OutfilePath  # Reliant on extension association
}
# End of Script
```
