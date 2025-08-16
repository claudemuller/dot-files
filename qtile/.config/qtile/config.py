import os
import subprocess
from libqtile import bar, layout, hook, widget
from libqtile.config import Click, Drag, DropDown, Group, Key, Match, Screen, ScratchPad
from libqtile.lazy import lazy
from qtile_extras import widget
from qtile_extras.widget.decorations import RectDecoration, PowerLineDecoration
import retro_term as theme
import subprocess

# -------------------------------------------------------------------------------------------------#
#                                             Vars                                                #
# -------------------------------------------------------------------------------------------------#

mod = "mod1"
terminal = "wezterm"
home = os.path.expanduser("~")
conf_dir = os.path.dirname(os.path.abspath(__file__))
colours = theme.RetroTerm('base')

# -------------------------------------------------------------------------------------------------#
#                                             Keys                                                #
# -------------------------------------------------------------------------------------------------#

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
    # Switch focus to next/previous monitor
    Key([mod, "control", "shift"], "l", lazy.next_screen(), desc="Next monitor"),
    Key([mod, "control", "shift"], "h", lazy.prev_screen(), desc="Previous monitor"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "c", lazy.window.kill(), desc="Kill focused window"),
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen on the focused window"),
    Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating on the focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.spawn("betterlockscreen -l dim"), desc="Lock screen"),
    # Key([mod, "control"], "l", lazy.spawn(home + "/.local/bin/lockscreen"), desc="Lock screen"),
    Key([mod, "control", "shift"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod, "control", "shift"], "r", lazy.spawn("autorandr --force && qtile cmd-obj -o cmd -f restart")),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    # Executables
    Key(
        [mod],
        "Return",
        lazy.spawn("WEZTERM_PROFILE=tmux " + terminal),
        desc="Launch terminal",
    ),
    Key(
        [mod],
        "space",
        lazy.spawn(home + "/.config/qtile/scripts/launcher"),
        desc="Launch Rofi",
    ),
    Key(
        [mod, "control"],
        "p",
        lazy.spawn(home + "/.config/qtile/scripts/pass"),
        desc="Launch password manager",
    ),
    Key(
        [mod, "control"],
        "c",
        lazy.spawn(home + "/.config/qtile/scripts/clipboard"),
        desc="Launch clipboard manager",
    ),
    Key(
        [mod, "control"],
        "t",
        lazy.spawn(home + "/.config/qtile/scripts/tmuxer"),
        desc="Launch TMUX manager",
    ),
    Key(
        [mod, "control"],
        "e",
        lazy.spawn(home + "/.config/qtile/scripts/emoji"),
        desc="Launch emoji manager",
    ),
    Key(
        [mod, "control"],
        "i",
        lazy.spawn(home + "/.config/qtile/scripts/add-to-inbox"),
        desc="Add note to inbox",
    ),
    Key(
        [mod, "control"],
        "v",
        lazy.spawn(home + "/.local/bin/vpn-picker"),
        desc="VPN picker",
    ),
    Key(
        [mod, "control"],
        "f",
        lazy.spawn(terminal + " -e yazi"),
        desc="Yazy File Browser",
    ),
    Key(
        [mod, "control", "shift"],
        "c",
        lazy.spawn(home + "/.config/qtile/scripts/calc"),
        desc="VPN picker",
    ),
    Key(
        [mod, "control", "shift"],
        "p",
        lazy.spawn("flameshot gui"),
        desc="Take a screenshot",
    ),
    #
    # Scratchpads
    Key([mod], "grave", lazy.group["scratchpad"].dropdown_toggle("special")),
    Key([mod, "control"], "n", lazy.group["scratchpad"].dropdown_toggle("notes")),
    Key([mod, "control"], "k", lazy.group["scratchpad"].dropdown_toggle("cheatsheet")),
    Key([mod, "control"], "s", lazy.group["scratchpad"].dropdown_toggle("spotify")),
    Key([mod, "control"], "b", lazy.group["scratchpad"].dropdown_toggle("browser")),
    Key([mod, "control"], "o", lazy.group["scratchpad"].dropdown_toggle("obsidian")),
    # Media Keys
    Key(
        [],
        "XF86AudioRaiseVolume",
        lazy.spawn("amixer set 'Master' 5%+"),
        desc="Increase volume",
    ),
    Key(
        [],
        "XF86AudioLowerVolume",
        lazy.spawn("amixer set 'Master' 5%-"),
        desc="Decrease volume",
    ),
    Key(
        [],
        "XF86AudioMute",
        lazy.spawn("amixer set 'Master' toggle"),
        desc="Mute volume",
    ),
    Key(
        [],
        "XF86AudioMicMute",
        lazy.spawn("amixer set Capture toggle"),
        desc="Mute microphone",
    ),
    Key(
        [],
        "XF86MonBrightnessUp",
        lazy.spawn("lux -a 15%"),
        desc="Increase screen brightness",
    ),
    Key(
        [],
        "XF86MonBrightnessDown",
        lazy.spawn("lux -s 15%"),
        desc="Decrease screen brightness",
    ),
    Key([], "Print", lazy.spawn("flameshot gui"), desc="Printscreen"),
    # Key([], 'FunnyKeys', lazy.spawn(''), desc='Decrease screen brightness'),
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


# -------------------------------------------------------------------------------------------------#
#                                            Groups                                               #
# -------------------------------------------------------------------------------------------------#

normal_groups = [Group(i) for i in "1234567890"]
groups = [
    ScratchPad(
        "scratchpad",
        [
            DropDown(
                "special",
                terminal + " -e " + home + "/.local/bin/run-tmux specialspace",
                opacity=1,
                height=0.9,
                on_focus_lost_hide=False,
                desc="Kitty",
            ),
            DropDown(
                "notes",
                terminal + " -e " + conf_dir + "/scripts/notes",
                opacity=1,
                height=0.9,
                on_focus_lost_hide=False,
                desc="Obsidian notes",
            ),
            DropDown(
                "cheatsheet",
                "qutebrowser " + home + "/repos/notes/cheatsheets/keybindings.html",
                opacity=1,
                height=0.9,
                on_focus_lost_hide=False,
                desc="Keybindings cheatsheet",
            ),
            DropDown(
                "spotify",
                "spotify",
                opacity=1,
                height=0.9,
                on_focus_lost_hide=False,
                desc="Spotify",
            ),
            DropDown(
                "browser",
                "qutebrowser",
                opacity=1,
                height=0.9,
                on_focus_lost_hide=False,
                desc="Qute browser",
            ),
            DropDown(
                "obsidian",
                "obsidian",
                opacity=1,
                height=0.95,
                width=0.95,
                x=0.02,
                on_focus_lost_hide=False,
                desc="Obsidian",
            ),
        ],
    ),
]
groups = normal_groups + groups

for i in normal_groups:
    keys.extend(
        [
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
        ]
    )


# -------------------------------------------------------------------------------------------------#
#                                           Layouts                                               #
# -------------------------------------------------------------------------------------------------#

layout_theme = dict(
    margin=[5, 5, 5, 5],
    border_normal=colours["bg_light"],
    border_focus=colours["highlight"],
    border_width=1,
    border_on_single=True,
)

layouts = [
    layout.Columns(**layout_theme),
    layout.MonadTall(**layout_theme),
    layout.MonadWide(**layout_theme),
    layout.Max(
        border_width=0,
        margin=0,
    ),
    # layout.Bsp(),
    # layout.Stack(num_stacks=2),
    # layout.Matrix(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]


# -------------------------------------------------------------------------------------------------#
#                                       Window Rules                                              #
# -------------------------------------------------------------------------------------------------#

floating_layout = layout.Floating(
    **layout_theme,
    float_rules=[
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(wm_class="burp-StartBurp"),
        Match(wm_class="Godot_Engine"),
        Match(wm_class="xup.class"),
        Match(wm_class="Learn me OpenGL"),
        Match(title="Demo"),
        Match(title="game"),
        Match(title="sitstand"),
        Match(title="That guy"),
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
        Match(title="Android Emulator.*"),
        Match(title="Burp Suite Pro Loader & Keygen"),
    ]
)


# -------------------------------------------------------------------------------------------------#
#                                             Bars                                                #
# -------------------------------------------------------------------------------------------------#

powerline_f = {
    "decorations": [
        PowerLineDecoration(path="forward_slash")
    ]
}
powerline_fp = {
    "decorations": [
        PowerLineDecoration(
            path="forward_slash",
            extrawidth=5,
        )
    ]
}
powerline_b = {
    "decorations": [
        PowerLineDecoration(path="back_slash")
    ]
}
powerline_bp = {
    "decorations": [
        PowerLineDecoration(
            path="back_slash",
            extrawidth=5,
        )
    ]
}
decoration_group = {
    "decorations": [
        RectDecoration(
            colour="#004040",
            radius=10,
            filled=True,
            # padding_y=4,
            group=True,
        )
    ],
    "padding": 10,
}

widget_defaults = dict(
    font="Hack Nerd Font",
    fontsize=10,
    padding=0,
    background=colours["bg_light"],
)
extension_defaults = widget_defaults.copy()

widget_opts = [
    widget.GroupBox(
        highlight_method="line",
        border_width=1,
        rounded=False,
        padding=5,
        active=colours["fg"],
        block_highlight_text_color=colours["highlight"],
        foreground=colours["red"],
        highlight_color=[colours["fg_dark"], colours["fg_dark"]],
        inactive=colours["comment"],
        this_current_screen_border=colours["highlight"],
        this_screen_border=colours["fg_dark"],
        other_current_screen_border=colours["text"],
        other_screen_border=colours["comment"],
        urgent_border=colours["highlight_sat"],
        urgent_text=colours["fg_dark"],
    ),
    widget.CurrentLayout(
        mode="icon",
        icon_first=True,
        padding=5,
        foreground=colours["text"],
    ),
    widget.Spacer(
        length=5,
        foreground=colours["text"],
        **powerline_b,
    ),

    widget.WindowName(
        fontsize=12,
        padding=5,
        foreground=colours["fg"],
        background=colours["transparent"],
        **powerline_b,
    ),
    widget.Chord(
        chords_colors={
            "launch": ("#ff0000", "#ffffff"),
        },
        name_transform=lambda name: name.upper(),
    ),

    widget.Spacer(
        length=10,
        foreground=colours["text"],
        background=colours["transparent"],
        **powerline_f,
    ),
    widget.OpenWeather(
        location="Stockholm",
        format='{location_city}: {icon} {main_temp}',
        padding=5,
        foreground=colours["text"],
        background=colours["bg"],
        **powerline_f,
    ),

    widget.TextBox(
        foreground=colours["text"],
        fmt="",
        fontsize=14,
        padding=5,
        **powerline_f,
    ),
    widget.MemoryGraph(
        graph_color=colours["highlight"],
        fill_color=colours["comment"],
        border_width=1,
        border_color=colours["comment"],
        **powerline_fp,
    ),

    widget.TextBox(
        foreground=colours["text"],
        fmt="",
        fontsize=14,
        padding=5,
        background=colours["bg"],
        **powerline_f,
    ),
    widget.CPUGraph(
        graph_color=colours["highlight"],
        fill_color=colours["comment"],
        border_width=1,
        border_color=colours["comment"],
        background=colours["bg"],
        **powerline_fp,
    ),

    # widget.Wlan(interface="wlan0"),
    widget.TextBox(
        foreground=colours["text"],
        fmt="󰛳",
        fontsize=14,
        padding=5,
        **powerline_f,
    ),
    widget.NetGraph(
        graph_color=colours["highlight"],
        fill_color=colours["comment"],
        border_width=1,
        border_color=colours["comment"],
        **powerline_fp,
    ),

    widget.TextBox(
        foreground=colours["text"],
        fmt="󰕾",
        fontsize=14,
        padding=5,
        background=colours["bg"],
        **powerline_f,
    ),
    # widget.PulseVolume(),
    widget.Volume(
        channel='Master',
        foreground=colours["fg"],
        background=colours["bg"],
        **powerline_fp,
    ),

    widget.TextBox(
        foreground=colours["text"],
        fmt="󱃂",
        fontsize=14,
        padding=5,
        **powerline_f,
    ),
    widget.ThermalSensor(
        tag_sensor='Package id 0',
        format="{temp:.1f}{unit}",
        foreground=colours["fg"],
        **powerline_fp,
    ),

    # widget.Bluetooth(),
    widget.TextBox(
        fmt="",
        fontsize=14,
        padding=5,
        foreground=colours["text"],
        background=colours["bg"],
        **powerline_f,
    ),
    widget.Battery(
        full_char="",
        charge_char="↑",
        discharge_char="↓",
        low_percentage=0.12,
        notify_below=12,
        max_chars=5,
        foreground=colours["fg"],
        background=colours["bg"],
        **powerline_fp,
    ),

    widget.CheckUpdates(
        distro="Arch",
        no_update_string="",
        display_format=" {updates}",
        foreground=colours["fg"],
    ),
    # widget.WiFiIcon(),
    # widget.IDW(
    #     show_image=True,
    #     show_text=False
    # ),
    widget.Pomodoro(
        prefix_inactive="",
        color_inactive=colours["fg"],
        padding=5,
        foreground=colours["fg"],
        **powerline_f,
    ),

    widget.Clock(
        format="%Y-%m-%d %a %H:%M %p",
        padding=5,
        foreground=colours["fg"],
        background=colours["bg"],
        **powerline_f,
    ),
    # widget.Spacer(
    #     length=1,
    #     background=colours["bg"],
    # ),
    widget.QuickExit(
        default_text="[X]",
        foreground=colours["fg"],
        background=colours["bg"],
    ),
]


def new_bar(widget_opts):
    bar_size = 24

    return bar.Bar(
        widget_opts,
        bar_size,
        margin=[0, 0, 5, 0],
        # border_width=bar_border,
        # border_color=colours["red"],
    )


def new_screen(b):
    return Screen(
        top=b,
        left=bar.Gap(5),
        right=bar.Gap(5),
        bottom=bar.Gap(5),
        # You can uncomment this variable if you see that on X11 floating resize/moving is laggy
        # By default we handle these events delayed to already improve performance, however your system might still be struggling
        # This variable is set to None (no cap) by default, but you can set it to 60 to indicate that you limit it to 60 events per second
        # x11_drag_polling_rate = 60,
    )


sec_screen = new_screen(new_bar(widget_opts))

ter_screen = new_screen(new_bar(widget_opts[:]))

prim_widget_opts = widget_opts[:-2] + [widget.Systray()] + widget_opts[-2:]
prim_screen = new_screen(new_bar(prim_widget_opts))

screens = [prim_screen, sec_screen, ter_screen]


# -------------------------------------------------------------------------------------------------#
#                                            Screens                                              #
# -------------------------------------------------------------------------------------------------#

window_gaps = 5

# screens = [
#         Screen(
#             # top=new_bar(colours, primary=True),
#             left=bar.Gap(window_gaps),
#             right=bar.Gap(window_gaps),
#             bottom=bar.Gap(window_gaps),
#             ),
#         Screen(
#             # top=new_bar(colours),
#             left=bar.Gap(window_gaps),
#             right=bar.Gap(window_gaps),
#             bottom=bar.Gap(window_gaps),
#             ),
#         Screen(
#             top=new_bar(colours, primary=True),
#             left=bar.Gap(window_gaps),
#             right=bar.Gap(window_gaps),
#             bottom=bar.Gap(window_gaps),
#             ),
#         ]


# -------------------------------------------------------------------------------------------------#
#                                            Mouse                                                #
# -------------------------------------------------------------------------------------------------#

# Drag floating layouts.
mouse = [
    Drag(
        ["mod1", "control"],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(["mod1", "control"], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click(["mod1", "control"], "Button2", lazy.window.bring_to_front()),
]


# -------------------------------------------------------------------------------------------------#
#                                             Misc                                                #
# -------------------------------------------------------------------------------------------------#

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
    home = os.path.expanduser("~")
    subprocess.call([home + "/.config/qtile/autostart.sh"])

# @hook.subscribe.screen_change
# def restart_on_randr(qtile, ev):
#     qtile.cmd_reconfigure_screens()
#     qtile.cmd_restart()

wmname = "LG3D"
