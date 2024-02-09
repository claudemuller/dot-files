from libqtile import bar, widget

def get_bar_widgets(opts):
    (colours) = opts

    widgets = [
            widget.GroupBox(
                highlight_method='block',
                border_width=1,
                active=colours[1],
                foreground=colours[1],
                rounded=False,
                this_current_screen_border=colours[3],
                this_screen_border=colours[3],
                ),
            widget.CurrentLayout(),
            # widget.Prompt(),
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
            widget.Wttr(location={'Kungsaengen': 'Home', 'Kista': 'Work'}),
            widget.TextBox(foreground=colours[3], fmt="", fontsize=14),
            widget.MemoryGraph(graph_color=colours[2], fill_color=colours[4], border_width=1, border_color=colours[4]),
            widget.TextBox(foreground=colours[3], fmt="", fontsize=14),
            widget.CPUGraph(graph_color=colours[2], fill_color=colours[4], border_width=1, border_color=colours[4]),
            widget.Wlan(interface="wlp0s20f3"),
            widget.TextBox(foreground=colours[3], fmt="󰛳", fontsize=14),
            widget.NetGraph(graph_color=colours[2], fill_color=colours[4], border_width=1, border_color=colours[4]),
            widget.TextBox(foreground=colours[3], fmt="󰕾", fontsize=14),
            widget.PulseVolume(),
            # widget.Volume(),
            widget.Spacer(length=1, background=colours[5]),
            widget.TextBox(foreground=colours[3], fmt="󱃂", fontsize=14),
            widget.ThermalSensor(format='{temp:.1f}{unit}'),
            widget.Bluetooth(),
            widget.TextBox(foreground=colours[3], fmt="", fontsize=14),
            widget.Battery(),
            widget.CheckUpdates(distro="Arch", no_update_string="", display_format=" {updates}"),
            widget.Clock(format="%Y-%m-%d %a %I:%M %p"),
            # widget.QuickExit(),
            ]

    return widgets


def new_bar(widget_opts):
    bar_size = 24

    return bar.Bar(
            widget_opts,
            bar_size,
            margin=[0, 0, 5, 0]
            # border_width=bar_border,
            # border_color=bar_border_colour,
            )

