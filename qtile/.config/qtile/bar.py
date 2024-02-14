from libqtile import bar, widget
from qtile_extras.widget.decorations import BorderDecoration
import os

def get_widget_defaults(colours):
    return dict(
            font="Hack Nerd Font",
            fontsize=10,
            padding=5,
            background=colours[1],
            )

def new_bar(colours, primary=False):
    bar_size = 24
    widgets = [
            widget.GroupBox(
                highlight_method='block',
                border_width=1,

                # active=colours[1],
                # foreground=colours[1],
                # this_current_screen_border=colours[3],
                # this_screen_border=colours[3],
                active='#ff000',
                inactive='#000000',
                highlight_color=['#f00000', '#0f0000'],
                foreground='#ffffff',
                this_current_screen_border='#00ff00',
                this_screen_border='#0000ff',

                rounded=False,
                ),
            widget.CurrentLayoutIcon(
                 foreground = colours[2],
                 padding = 4,
                 scale = 0.6
                 ),
            # widget.CurrentLayout(
            #     foreground = colours[2],
            #     padding = 5
            #     ),
            widget.WindowName(),
            widget.Chord(
                chords_colors={
                    "launch": ("#ff0000", "#ffffff"),
                    },
                name_transform=lambda name: name.upper(),
                ),
            # NB Systray is incompatible with Wayland, consider using StatusNotifier instead
            # widget.StatusNotifier(),
            # widget.OpenWeather(location="Stockholm", format='{location_city}: {icon} {main_temp}'),
            widget.Wttr(location={'Kungsaengen': 'Home'}),
            widget.Wlan(interface="wlp0s20f3"),
            widget.TextBox(foreground=colours[3], fmt="󰛳", fontsize=14),
            widget.NetGraph(graph_color=colours[2], fill_color=colours[4], border_width=1, border_color=colours[4]),
            widget.TextBox(foreground=colours[3], fmt="", fontsize=14),
            widget.MemoryGraph(graph_color=colours[2], fill_color=colours[4], border_width=1, border_color=colours[4]),
            widget.TextBox(foreground=colours[3], fmt="", fontsize=14),
            widget.CPUGraph(graph_color=colours[2], fill_color=colours[4], border_width=1, border_color=colours[4]),
             widget.DF(
                 update_interval = 60,
                 foreground = colours[3],
                 # mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(myTerm + ' -e df')},
                 partition = '/',
                 format = '[{p}] {uf}{m} ({r:.0f}%)',
                 # format = '{uf}{m} free',
                 fmt = '🖴  {}',
                 visible_on_warn = False,
                 decorations=[
                     BorderDecoration(
                         colour = colours[3],
                         border_width = [0, 0, 2, 0],
                     )
                 ],
                 ),
            widget.TextBox(foreground=colours[3], fmt="󰕾", fontsize=14),
            # widget.PulseVolume(),
            widget.Volume(
                 foreground = colours[3],
                 fmt = '{}',
                 decorations=[
                     BorderDecoration(
                         colour = colours[3],
                         border_width = [0, 0, 2, 0],
                     )
                 ],
                 ),
            widget.Spacer(length=1, background=colours[5]),
            widget.TextBox(foreground=colours[3], fmt="󱃂", fontsize=14),
            widget.ThermalSensor(format='{temp:.1f}{unit}'),
            widget.TextBox(
                 text = '|',
                 font = "Ubuntu Mono",
                 foreground = colours[2],
                 padding = 2,
                 fontsize = 14
                 ),
            widget.Bluetooth(),
            widget.TextBox(foreground=colours[3], fmt="", fontsize=14),
            widget.Battery(),
            widget.CheckUpdates(distro="Arch", no_update_string="", display_format=" {updates}"),
            widget.Clock(format="%Y-%m-%d %a %I:%M %p"),
            # widget.QuickExit(),
            ]

    if primary:
        widgets = widgets[:-2] + [widget.Systray()] + widgets[-2:]

    return bar.Bar(
            widgets,
            bar_size,
            margin=[0, 0, 5, 0]
            )

