from libqtile import hook
from libqtile.lazy import lazy

import subprocess

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


