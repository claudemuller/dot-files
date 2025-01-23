# PowerShell script to set an environment variable and launch WezTerm
$env:WEZTERM_PROFILE = "manjaro"

# Update with the actual path to wezterm-gui.exe
Start-Process -FilePath "wezterm-gui.exe"
exit
