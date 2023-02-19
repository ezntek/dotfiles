# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from libqtile import bar, layout
from qtile_extras import widget
from qtile_extras.widget.decorations import RectDecoration, PowerLineDecoration
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile import hook
import subprocess
import datetime
import os

mod = "mod4"
terminal="kitty"

# some utility functions
@hook.subscribe.startup_once
def autostart():
    subprocess.run("$HOME/.config/qtile/autostart.sh", shell=True)

def move_window_to_screen(qtile, window, screen):
    window.togroup(screen.group.name)
    qtile.focus_screen(screen.index)
    screen.group.focus(window, True)

@lazy.function
def move_window_to_next_screen(qtile):
    """
    Moves a window to the next screen. Loops around the beginning and
    end.
    """
    index = qtile.current_screen.index
    index = index + 1 if index < len(qtile.screens) - 1 else 0
    move_window_to_screen(qtile, qtile.current_window, qtile.screens[index])

def window_to_next_screen(qtile, switch_group=False, switch_screen=True):
    idx = qtile.screens.index(qtile.current_screen)
    if idx + 1 <= len(qtile.screens):
        group = qtile.screens[idx+1].group.name
        qtile.current_window.togroup(group, switch_group=switch_group)
        qtile.cmd_to_screen(idx+1) if switch_screen is True else None

def window_to_prev_screen(qtile, switch_group=False, switch_screen=True):
    idx = qtile.screens.index(qtile.current_screen)
    if idx != 0:
        group = qtile.screens[idx-1].group.name
        qtile.current_window.togroup(group, switch_group=switch_group)
        qtile.cmd_to_screen(idx-1) if switch_screen is True else None

DECORATIONS_R = {
    "decorations": [
        PowerLineDecoration(path="arrow_right")
    ],
    "foreground": "#585b70", 
    "font": "Iosevka Medium",
    "fontsize": 14,
}

DECORATIONS_L = {
    "decorations": [
        PowerLineDecoration(path="arrow_left")
    ],
    "foreground": "#585b70",
    "font": "Iosevka Medium",
    "fontsize": 14,
}

DECORATIONS_LR = {
    "decorations": [
        PowerLineDecoration(path="arrow_left"),
        PowerLineDecoration(path="arrow_right")
    ],
    "foreground": "#cdd6f4",
}
alt="mod1"

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "n", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "i", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "e", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "u", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "n", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "i", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "e", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "u", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "n", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "i", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "e", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "u", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod, "control", "shift"], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
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
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "shift"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "shift"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "space", lazy.spawn("rofi -show drun")),
    Key([mod, "control"], "r", lazy.spawncmd()), 

    # Multiple Monitors
    Key(["control", "shift"], "n", lazy.next_screen()),
    Key(["control", alt], "n", lazy.function(window_to_next_screen)),
    Key(["control", alt], "e", lazy.function(window_to_prev_screen)),
    #screenshots
    Key([mod, "shift"], "s", lazy.spawn("mate-screenshot -a")),
    Key([mod, "control"], "s", lazy.spawn("mate-screenshot"))
]

groups = [Group(i) for i in "12345"]

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ],
    border_focus = "#bac2de",
    border_normal="#45475a",
    border_width=3
)
layouts = [
    layout.Columns(border_focus = "#bac2de", border_normal="#45475a", border_width=3, margin=6),
    floating_layout,
    layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = {
        "font": "Iosevka Medium",
        "fontsize": 14,
        "padding": 4,
}
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(background="#f38ba8", highlight_method="border", this_current_screen_border="#94e2d5", other_screen_border="a6adc8", disable_drag=True, **DECORATIONS_L),
                widget.Prompt(background="#eba0ac", **DECORATIONS_L),
                widget.TaskList(background="#45475a",highlight_method="block", border="#313244", **DECORATIONS_LR),
                widget.Systray(background="#fab387", **DECORATIONS_R),
                widget.PulseVolume(background="#94e2d5", fmt="  {} ", **DECORATIONS_R),
                widget.Clock(background="#74c7ec", format="  %a %d %B, %Y", **DECORATIONS_R),
                widget.Clock(background="#89b4fa", format="  %H:%M:%S", foreground="#45475a", font="Iosevka Medium"),
            ],
            32,
            margin=6, 
            background="#1e1e2e",
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
        bottom=bar.Bar(
            [
                widget.CurrentLayout(background="89dceb", **DECORATIONS_L),
                widget.Spacer(background="45475a", **DECORATIONS_LR),
                widget.Visualiser(cava_path="/usr/bin/cava", background="#f5e0dc", **DECORATIONS_R),
                widget.Memory(format="  {MemUsed:.0f}{mm}", background="#f2cdcd", **DECORATIONS_R),
                widget.CPU(format="  {load_percent}%", background="#f5c2e7", **DECORATIONS_R),
                widget.ThermalSensor(format=' {temp}{unit}', font="Iosevka Medium", background="#eba0ac", foreground="45475a"),
            ],
            32,
            margin=6,
            background="#1e1e2e"
        ),
        wallpaper="~/Pictures/mountain_middle.png",
        wallpaper_mode="fill"
    ),
    Screen(
        top=bar.Bar(
            [
                widget.CurrentLayout(background="eba0ac", **DECORATIONS_L),
                widget.Clock(background="cba6f7", format="  %H:%M:%S", **DECORATIONS_L),
                widget.TaskList(background="45475a", highlight_method="block", border="313244", **DECORATIONS_LR),
                widget.PulseVolume(background="#f5c2e7", fmt="  {} ", foreground="#45475a", font="Iosevka Medium")
            ],
            32,
            margin=6,
            background="#45475a"
        ),
        wallpaper="~/Pictures/the_valley.png",
        wallpaper_mode="fill"
    )
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True
wmname="qtile"
# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None
