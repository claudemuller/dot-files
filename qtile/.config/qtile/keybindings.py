from libqtile.config import Key
from libqtile.lazy import lazy

# Add key bindings to switch VTs in Wayland.
# We can't check qtile.core.name in default config as it is loaded before qtile is started
# We therefore defer the check until the key binding is run by using .when(func=...)
# for vt in range(1, 8):
#     keys.append(
#         Key(
#             ["control", "mod1"],
#             f"f{vt}",
#             lazy.core.change_vt(vt).when(func=lambda: qtile.core.name == "wayland"),
#             desc=f"Switch to VT{vt}",
#         )
#     )

def get_keys(opts):
    (mod, home, term) = opts

    return [
            # Switch between windows
            Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
            Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
            Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
            Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
            # Key([mod], "w", lazy.layout.next(), desc="Move window focus to other window"),

            # Move windows between left/right columns or move up/down in current stack. Moving out of range in Columns 
            # layout will create new column.
            Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
            Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
            Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
            Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

            # Move between screens
            Key([mod], 'period', lazy.next_screen(), desc='Next monitor'),

            # Grow windows. If current window is on the edge of screen and direction will be to screen edge - window
            # would shrink.
            Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
            Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
            Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
            Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
            Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

            # Toggle between split and unsplit sides of stack.
            # Split = all windows displayed
            # Unsplit = 1 window displayed, like Max layout, but still with
            # multiple stack panes
            Key([mod, "shift"], "Return", lazy.layout.toggle_split(), desc="Toggle between split and unsplit sides of stack"),

            # Toggle between different layouts as defined below
            Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
            Key([mod], "c", lazy.window.kill(), desc="Kill focused window"),
            Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen on the focused window"),
            Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating on the focused window"),
            Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
            Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
            Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),

            # Executables
            Key([mod], "Return", lazy.spawn(term + " -e " + home + "/.local/bin/run-tmux"), desc="Launch terminal"),
            Key([mod], "space", lazy.spawn(home + "/.config/qtile/scripts/launcher"), desc="Launch Rofi"),

            # Scratchpads
            Key([mod], 'grave', lazy.group['scratchpad'].dropdown_toggle('special')),
            Key([mod, "control"], 'n', lazy.group['scratchpad'].dropdown_toggle('notes')),
            Key([mod, "control"], 'c', lazy.group['scratchpad'].dropdown_toggle('cheatsheet')),
            ]
