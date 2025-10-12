+++
date = '2025-10-12'
draft = true
title = 'Using YT-DLP With UVX'
tags = ["UV", "UVX", "yt-dlp"]
+++

## Introduction

YT‑DLP is a fast, actively maintained command-line tool for downloading audio and video from many sites. I use it to extract audio from videos for offline listening on walks. This post shows a simple, reproducible workflow using UV/UVX so you can run YT‑DLP without installing it system‑wide, plus a small PowerShell helper script to make converting downloads easier.

What you’ll find here:

- How I run YT‑DLP via UVX
- A ready-to-use PowerShell script
- Prerequisites and quick troubleshooting tips

**Legal/Terms reminder**: only download content you have the right to store or that is permitted by the content provider's terms of service.

## Prerequisites

- [UV](https://docs.astral.sh/uv/) installed and configured (`uvx` is an alias for `uv tool run`)
- Windows with PowerShell 7+ (for the scripts, the UVX commands will work outside of PowerShell)
- FFmpeg binaries available locally (required for audio extraction)

## Troubleshooting

- _uvx not found_: ensure UV is installed and `uv` is on the PATH. `uv tool run` is equivalent to `uvx`.
- _FFmpeg missing_: YT‑DLP will fail to extract audio without FFmpeg. Verify the path passed to `--ffmpeg-location` points to the directory containing `ffmpeg.exe`.
- _Permission errors writing files_: run PowerShell as a user that can write to the target folder or change the RootFolder to a writeable location.
- _Network/download failures_: try again with `--verbose` to see error details; some sites require cookies or authentication.
- _File name collisions_: the script writes to the chosen filename; check for existing files.
- _Reproducibility vs latest_: using `--no-cache` with `uvx` fetches the latest tool each run (useful for yt-dlp's rapid updates). Remove it for more reproducible runs.

## UVX Commands

These are what I use to extract the audio from videos. You will be able to modify for your needs:

```pwsh
# PowerShell
# Setup some Aliases for this Example
$UrlLink     = "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
$OutFilename = "RickRoll.mp3"
$AudioFormat = "mp3"  
$TempFolder  = "c:\temp\yt-dlp"  # My temp store before I copy to Phone/MP3 player
$FFmpegPath  = join-path -path $TempFolder -childpath "ffmpeg-master-latest-win64-gpl\bin"  # Required binaries for audio extraction

cd $TempFolder  # Go to my temp store

# Run YT-DLP via UVX
uvx --no-cache yt-dlp -x --audio-format $AudioFormat --ffmpeg-location $FFmpegPath -o $OutFilename $UrlLink --verbose
```

```pwsh
# Command breakdown 
uvx --no-cache yt-dlp         # Get the latest yt-dlp every time
-x                            # Convert video files to audio-only files
                              # (Use -k to keep the intermediate video)
--audio-format $AudioFormat   # Use the specified audio format 
--ffmpeg-location $FFmpegPath # Location of FFMPEG binary: exe path or just dir
-o $OutFilename               # Output filename
$UrlLink                      # URL to video to extract audio from
--verbose                     # Optional: print debugging information
```

The audio extraction requires the FFMPEG binaries which can be [downloaded from here](https://github.com/yt-dlp/FFmpeg-Builds). Simply extract to somewhere convenient.

---

### Making It Simple For Me

As a PowerShell script, e.g., `download_yt_audio.ps1`:

```pwsh
#Powershell Script: .\download_yt_audio.ps1
# Defaults, change as required
$DefaultRootFolder  = "C:\temp\yt-dlp"
$DefaultAudioFormat = "mp3"  # aac, alac, flac, m4a, mp3, opus, vorbis, wav
$DefaultFFmpegPath  = "C:\temp\yt-dlp\ffmpeg-master-latest-win64-gpl\bin"
$DefaultAutoPlay    = $false
$Verbosity          = "--quiet"  # Change to "--verbose" for more output

# Check UVX is available on the path
if (-not (Test-Path (get-command uvx.exe).Path)) {
    Write-Host "No uvx.exe found. Check it is available on your path."
    exit 1
}

# Get user inputs or use defaults
$UrlLink = Read-Host "URL/Link of Video"
if (-not $UrlLink) { Write-Error "You must provide a URL."; exit 1 }

[ValidateSet('aac', 'alac', 'flac', 'm4a', 'mp3', 'opus', 'vorbis', 'wav', '')]$AudioFormat = Read-Host 'Audio Format (default:' $DefaultAudioFormat')'
# It's a coarse error if it fails, but it's at least a check
if (-not $AudioFormat) { $AudioFormat = $DefaultAudioFormat }  # '' option

$Filename = Read-Host "Output Filename (no extension)"
if (-not $Filename) { Write-Error "You must provide an output filename."; exit 1 }

$FFmpegPath = Read-Host 'FFMPEG Folder (default:' $DefaultFFmpegPath ')'
if (-not $FFmpegPath) { $FFmpegPath = $DefaultFFmpegPath }

# Validate ffmpeg path
$FFmpegExePath = Join-Path -Path $FFmpegPath -ChildPath "ffmpeg.exe"
if (-not (Test-Path -Path $FFmpegExePath)) {
    Write-Warning "FFmpeg executable not found at: $FFmpegExePath"
    exit 1  # Alternatively ask user to get the path correct
}

$RootFolder = Read-Host 'Root Folder (default:' $DefaultRootFolder ')'
if (-not $RootFolder) { $RootFolder = $DefaultRootFolder }

# Ensure root folder exists
if (-not (Test-Path -Path $RootFolder)) {
    Write-Host "Creating $RootFolder"
    New-Item -Path $RootFolder -ItemType Directory -Force | Out-Null
}

$AutoPlay = Read-Host 'AutoPlay Audio after Extraction? (default off)'
if (-not($AutoPlay)) { $AutoPlay = $DefaultAutoPlay}

$OutFilename = "$Filename.$AudioFormat"  # Append format as extension

Set-Location -Path $RootFolder  # Go to root folder

# UVX args: use --no-cache to fetch latest yt-dlp version each time
$uvxArgs = @("--no-cache",
             "yt-dlp",
             "-x",
             "--audio-format", $AudioFormat,
             "--ffmpeg-location", $FFmpegPath,
             "-o", $OutFilename,
             $UrlLink,
             $Verbosity
             )

Write-Host "Running: uvx $($uvxArgs -join ' ')"
& uvx @uvxArgs
# Let UV handle errors

# Optionally play the downloaded audio
if ($AutoPlay) {
    $OutfilePath = Join-Path -Path $RootFolder -ChildPath $OutFilename
    if (Test-Path $OutfilePath) {
        Start-Process -FilePath $OutfilePath
    } else {
        Write-Warning "Downloaded file not found: $OutfilePath"
    }
}
# End of Script
```
