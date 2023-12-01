if application "kitty" is running then
  tell application "System Events" to tell process "kitty"
    click menu item "New OS Window" of menu 1 of menu bar item "Shell" of menu bar 1
  end tell
else
  activate application "kitty"
end if
