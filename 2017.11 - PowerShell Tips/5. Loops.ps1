#region Safety
throw "You're not supposed to hit F5"
#endregion"

# Foreach vs. ForEach-Object


# "Downloading" the movie, high memory usage, fast, slower first results, readable
$files = dir -Path C:\Windows -File
foreach ($file in $files) {
    "Working with " + $file.Name
}

# "Streaming" the movie, low memory usage, slow, faster first results, less readable 
dir -Path C:\Windows -File | ForEach-Object {
    "Working with " + $_.Name
}


# You can, but don't
$files = dir -Path C:\Windows -File
for ($i = 1; $i -lt $files.Count; $i++) { 
    "Working with " + $files[$i].Name
}