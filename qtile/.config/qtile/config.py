import os
import subprocess
from libqtile import bar, layout, hook, widget
from libqtile.config import Click, Drag, DropDown, Group, Key, Match, Screen, ScratchPad
from libqtile.lazy import lazy
import colours


#-------------------------------------------------------------------------------------------------#
#                                             Vars                                                #
#-------------------------------------------------------------------------------------------------#

mod = "mod4"
terminal = "kitty"
home = os.path.expanduser('~')
conf_dir = os.path.dirname(os.path.abspath(__file__))
colours = colours.TokyoNight


#-------------------------------------------------------------------------------------------------#
#                                             Keys                                                #
#-------------------------------------------------------------------------------------------------#

keys = [
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
        Key([mod], "Return", lazy.spawn(terminal + " -e " + home + "/.local/bin/run-tmux"), desc="Launch terminal"),
        Key([mod], "space", lazy.spawn(home + "/.config/leftwm/themes/current/scripts/launcher"), desc="Launch Rofi"),

        # Scratchpads
        Key([mod], 'grave', lazy.group['scratchpad'].dropdown_toggle('special')),
        Key([mod, "control"], 'n', lazy.group['scratchpad'].dropdown_toggle('notes')),
        Key([mod, "control"], 'c', lazy.group['scratchpad'].dropdown_toggle('cheatsheet')),
        ]

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


#-------------------------------------------------------------------------------------------------#
#                                            Groups                                               #
#-------------------------------------------------------------------------------------------------#

normal_groups = [Group(i) for i in "1234567890"]
groups = [
    ScratchPad("scratchpad", [
        DropDown("special", terminal + " -e echo tes", opacity=0.8, desc="Kitty"),
        DropDown(
            "notes",
            terminal + " -e " + conf_dir + "/scripts/notes",
            opacity=0.8,
            height=0.8,
            on_focus_lost_hide=False,
            desc="Obsidian notes",
            ),
        DropDown(
            "cheatsheet",
            terminal + " -e " + conf_dir + "/scripts/cheatsheet",
            opacity=0.8,
            height=0.8,
            on_focus_lost_hide=False,
            desc="Keybindings cheatsheet",
            ),
        # # define another terminal exclusively for ``qtile shell` at different position
        # DropDown("qtile shell", "urxvt -hold -e 'qtile shell'",
        #          x=0.05, y=0.4, width=0.9, height=0.6, opacity=0.9,
        #          on_focus_lost_hide=True) ]),
    ]),
]
groups = normal_groups + groups

for i in normal_groups:
    keys.extend(
            [
                # mod1 + group number = switch to group
                Key(
                    [mod],
                    i.name,
                    lazy.group[i.name].toscreen(),
                    desc="Switch to group {}".format(i.name),
                    ),
                # mod1 + shift + group number = switch to & move focused window to group
                Key(
                    [mod, "shift"],
                    i.name,
                    lazy.window.togroup(i.name, switch_group=True),
                    desc="Switch to & move focused window to group {}".format(i.name),
                    ),
                # Or, use below if you prefer not to switch to that group.
                # # mod1 + shift + group number = move focused window to group
                # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
                #     desc="move focused window to group {}".format(i.name)),
                ]
            )


#-------------------------------------------------------------------------------------------------#
#                                           Layouts                                               #
#-------------------------------------------------------------------------------------------------#

layouts = [
        layout.Columns(
            margin=[5,5,5,5],
            border_normal=colours[1],
            border_focus=colours[6],
            border_width=1,
            border_on_single=True),
        layout.Max(),

        # Try more layouts by unleashing below layouts.
        # layout.Bsp(),
        # layout.Stack(num_stacks=2),
        # layout.Matrix(),
        # layout.MonadTall(),
        # layout.MonadWide(),
        # layout.RatioTile(),
        # layout.Tile(),
        # layout.TreeTab(),
        # layout.VerticalTile(),
        # layout.Zoomy(),
        ]


#-------------------------------------------------------------------------------------------------#
#                                             Bars                                                #
#-------------------------------------------------------------------------------------------------#

widget_defaults = dict(
        font="Hack Nerd Font",
        fontsize=10,
        padding=5,
        background=colours[1],
        )
extension_defaults = widget_defaults.copy()

widget_opts = [
        widget.GroupBox(),
        widget.CurrentLayout(),
        widget.Prompt(),
        widget.WindowName(),
        widget.Chord(
            chords_colors={
                "launch": ("#ff0000", "#ffffff"),
                },
            name_transform=lambda name: name.upper(),
            ),
        # NB Systray is incompatible with Wayland, consider using StatusNotifier instead
        # widget.StatusNotifier(),
        widget.TextBox(fmt=""),
        widget.MemoryGraph(graph_color=colours[2], fill_color=colours[4], border_width=1, border_color=colours[4]),
        widget.TextBox(fmt=""),
        widget.CPUGraph(graph_color=colours[2], fill_color=colours[4], border_width=1, border_color=colours[4]),
        widget.Wlan(interface="wlp0s20f3"),
        widget.TextBox(fmt="↓↑"),
        widget.NetGraph(graph_color=colours[2], fill_color=colours[4], border_width=1, border_color=colours[4]),
        widget.PulseVolume(),
        # widget.Volume(),
        widget.Spacer(length=1, background=colours[5]),
        widget.ThermalSensor(),
        widget.BatteryIcon(),
        widget.CheckUpdates(distro="Arch", no_update_string="", display_format=" {updates}"),
        widget.Clock(format="%Y-%m-%d %a %I:%M %p"),
        # widget.QuickExit(),
        ]
bar_size = 24


#-------------------------------------------------------------------------------------------------#
#                                            Screens                                              #
#-------------------------------------------------------------------------------------------------#

sec_screen = Screen(
        top=bar.Bar(
            widget_opts,
            bar_size,
            # border_width=bar_border,
            # border_color=bar_border_colour,
            ),
        # You can uncomment this variable if you see that on X11 floating resize/moving is laggy
        # By default we handle these events delayed to already improve performance, however your system might still be struggling
        # This variable is set to None (no cap) by default, but you can set it to 60 to indicate that you limit it to 60 events per second
        # x11_drag_polling_rate = 60,
        )

ter_screen = Screen(
        top=bar.Bar(
            [
                widget.GroupBox(),
                widget.WindowName(),
                widget.Clock()
                ],
            bar_size,
            ),
        )

prim_widget_opts = widget_opts[:-2] + [widget.Systray()] + widget_opts[-2:]
prim_screen = Screen(
        top=bar.Bar(
            prim_widget_opts,
            bar_size,
            ),
        )

screens = [prim_screen, sec_screen, ter_screen]


#-------------------------------------------------------------------------------------------------#
#                                            Mouse                                                #
#-------------------------------------------------------------------------------------------------#

# Drag floating layouts.
mouse = [
        Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
        Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
        Click([mod], "Button2", lazy.window.bring_to_front()),
        ]


#-------------------------------------------------------------------------------------------------#
#                                       Window Rules                                              #
#-------------------------------------------------------------------------------------------------#

floating_layout = layout.Floating(
        float_rules=[
            # Run the utility of `xprop` to see the wm class and name of an X client.
            *layout.Floating.default_float_rules,
            Match(wm_class="confirmreset"),  # gitk
            Match(wm_class="makebranch"),  # gitk
            Match(wm_class="maketag"),  # gitk
            Match(wm_class="ssh-askpass"),  # ssh-askpass
            Match(wm_class="burp-StartBurp"),
            Match(title="branchdialog"),  # gitk
            Match(title="pinentry"),  # GPG key password entry
            Match(title="Android Emulator.*"),
            Match(title="Burp Suite Pro Loader & Keygen"),
            ]
        )


#-------------------------------------------------------------------------------------------------#
#                                             Misc                                                #
#-------------------------------------------------------------------------------------------------#

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])

wmname = "LG3D"