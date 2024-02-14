import os
import subprocess
from libqtile import bar, layout, hook, widget
from libqtile.config import Click, Drag, DropDown, Group, Key, Match, Screen, ScratchPad
from libqtile.lazy import lazy
import colours
from keybindings import get_keys
from bar import get_bar_widgets, new_bar


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

keys = get_keys(dict(mod=mod, home=home, term=terminal))


#-------------------------------------------------------------------------------------------------#
#                                            Groups                                               #
#-------------------------------------------------------------------------------------------------#

normal_groups = [Group(i) for i in "1234567890"]
groups = [
        ScratchPad("scratchpad", [
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
                terminal + " -e " + conf_dir + "/scripts/cheatsheet",
                opacity=1,
                height=0.9,
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
#                                       Window Rules                                              #
#-------------------------------------------------------------------------------------------------#

floating_layout = layout.Floating(
        border_normal=colours[1],
        border_focus=colours[6],
        border_width=1,
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
#                                             Bars                                                #
#-------------------------------------------------------------------------------------------------#

widget_defaults = dict(
        font="Hack Nerd Font",
        fontsize=10,
        padding=5,
        background=colours[1],
        )
extension_defaults = widget_defaults.copy()

(widget_opts, bar_size) = get_bar_widgets(dict(colours=colours))


#-------------------------------------------------------------------------------------------------#
#                                            Screens                                              #
#-------------------------------------------------------------------------------------------------#

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
