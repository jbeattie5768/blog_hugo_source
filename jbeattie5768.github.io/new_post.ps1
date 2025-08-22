param(
    [Parameter(Position=0)]
    [string]$InputTitle = ""
)

# Clean up the title to create the slug
$TitleTidy = $InputTitle -replace ':', '' # Remove colons
$TitleTidy = $TitleTidy -replace '\s+', '-' -replace '_', '-' # Replace spaces and underscores with hyphens
$TitleTidy = $TitleTidy -replace '-+', '-' # Replace multiple hyphens with single hyphen
$TitleTidy = $TitleTidy.Trim('-') # Remove leading/trailing hyphens
$TitleTidy = $TitleTidy.ToLower() # Convert to lowercase
$PrefixDate = Get-Date -Format "yyyy-MM-dd"
$Slug = "$PrefixDate-$TitleTidy"

# Display information
Write-Output $InputTitle
Write-Output $TitleTidy
Write-Output $PrefixDate
Write-Output $Slug

# Create new post
hugo new content "posts/$Slug/index.md"
