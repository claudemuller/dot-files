# PowerShell script to set an environment variable and launch WezTerm
$env:PROFILE = "manjaro"

# Update with the actual path to wezterm-gui.exe
Start-Process -FilePath "C:\Users\dief\Downloads\WezTerm-windows-nightly\WezTerm-windows-20241015-083151-9ddca7bd\wezterm-gui.exe"

