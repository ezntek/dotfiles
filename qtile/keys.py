from utils import * 

from libqtile.lazy import lazy
from libqtile.config import Group, Key 

mod = "mod4"
alt = "mod1"
terminal = "kitty"

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
    Key([mod, "control"], "Return", lazy.spawn("xfce4-terminal")),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "shift"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "shift"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "space", lazy.spawn("rofi -show drun")),
    Key([mod, "control"], "r", lazy.spawncmd()), 

    # Multiple Monitors
    Key(["control", "shift"], "n", lazy.next_screen()),
    Key(["control", "shift"], "e", lazy.prev_screen()),
    Key(["control", alt], "n", lazy.function(window_to_next_screen)),
    Key(["control", alt], "e", lazy.function(window_to_prev_screen)),
    #screenshots
    Key([mod, "shift"], "s", lazy.spawn("xfce4-screenshooter -r -s Nextcloud/Pictures/screenshots")),
    Key([mod, "control"], "s", lazy.spawn("xfce4-screenshooter -f -s Nextcloud/Pictures/screenshots")),
    # poweroff
    Key([mod, "control"], "q", lazy.spawn("rofi -show p -modi p:'~/.local/bin/rofi-power-menu --symbols-font \"Iosevka Dlig SS20\"' -font \"Iosevka Dlig SS20 16\" -theme custom"))
]

# groups becasue keys
groups = [
    Group(i) for i in "12345"]

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


