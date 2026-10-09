import libqtile
import libqtile.widget
from decorations import *

import subprocess
from libqtile import bar
from qtile_extras import widget


class PowerProfilesDaemon(libqtile.widget.base.BackgroundPoll):
    """A widget to display the current power setting of power-profiles-daemon"""

    defaults = [
        ("func", None, "Poll Function"),
    ]

    def __init__(self, **config):
        libqtile.widget.base.BackgroundPoll.__init__(self, "", **config)
        self.func = None
        self.current_state = "balanced"
        self.update_interval = 1
        self.mouse_callbacks = {"Button1": self.next_state, "Button2": self.prev_state}

    def next_state(self):
        match self.current_state:
            case "performance":
                self.current_state = "power-saver"
            case "balanced":
                self.current_state = "performance"
            case "power-saver":
                self.current_state = "balanced"

        subprocess.run(f"powerprofilesctl set {self.current_state}", shell=True)

    def prev_state(self):
        match self.current_state:
            case "performance":
                self.current_state = "balanced"
            case "balanced":
                self.current_state = "power-saver"
            case "power-saver":
                self.current_state = "performance"

        subprocess.run(f"powerprofilesctl set {self.current_state}", shell=True)

    def poll(self) -> str:
        process = subprocess.run(
            "powerprofilesctl get",
            capture_output=True,
            text=True,
            shell=True,
        )
        setting = process.stdout.strip()

        self.current_state = setting
        return f" P {setting} "


def bottom_main_screen():
    return bar.Bar(
        [
            widget.GroupBox(
                urgent_border="#ed8796",
                inactive="#6e738d",
                padding=0,
                margin_x=5,
                margin_y=3,
                borderwidth=1,
                this_screen_border="#a5adcb",
                this_current_screen_border="#a5adcb",
                other_screen_border="#45475a",
                other_current_screen_border="#45475a",
                disable_drag=True,
                background="#24273a",
            ),
            widget.WindowName(
                padding=10,
                # theme_path="/usr/share/icons/Papirus-dark",
                txt_floating="[F] ",
                txt_maximized="[+] ",
                txt_minimized="[-] ",
            ),
            widget.StatusNotifier(
                icon_theme="Papirus-dark",
                padding=0,
                menu_font="Iosevka",
                menu_fontsize=12,
                menu_background="1e2030",
                highlight_colour="cba6f7",
                background="#24273a",
            ),
            widget.PulseVolume(fmt=" V {} ", margin=0, background="#24273a"),
            widget.Memory(
                update_interval=2,
                format=" M {MemUsed:.0f}{mm} ",
            ),
            widget.CPU(
                update_interval=2,
                format=" C {load_percent}% ",
                threshold=80,
                foreground_alert="#ed8796",
                background="#24273a",
            ),
            widget.ThermalSensor(
                format=" T {temp}{unit} ",
            ),
            widget.Battery(
                update_interval=2,
                charge_char="B+",
                discharge_char="B-",
                empty_char="B",
                full_char="B ",
                format=" {char} {percent:2.0%} ({hour:d}h{min:02d}m) ",
                background="#24273a",
            ),
            #PowerProfilesDaemon(),
            widget.Clock(format=" %F (%a) %H:%M:%S", background="#24273a"),
        ],
        20,  # height
        background="#1e2030",
        # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
        # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
    )
