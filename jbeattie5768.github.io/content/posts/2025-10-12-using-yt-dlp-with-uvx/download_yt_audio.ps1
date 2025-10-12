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
