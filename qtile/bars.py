import libqtile
from decorations import * 

import subprocess
from libqtile import bar
from qtile_extras import widget

top_bar_main_screen = bar.Bar(
    [
        widget.GroupBox(
            urgent_border="#ed8796",
            inactive="#6e738d",
            padding=0,
            margin_x=5,
            margin_y=3,
            this_screen_border="#7dc4e4",
            this_current_screen_border="#7dc4e4",
            other_screen_border="#45475a",
            other_current_screen_border="#45475a",
            disable_drag=True,
            background="#24273a"
        ),
        widget.WindowName(
            padding=10,
            #theme_path="/usr/share/icons/Papirus-dark",
            txt_floating="🗗",
            txt_maximized="🗖",
            txt_minimized="🗕", 
        ),
        widget.StatusNotifier(
            icon_theme="Papirus-dark",
            padding=0,
            menu_font="Inter",
            menu_fontsize=12,
            menu_background="1e2030",
            highlight_colour="cba6f7",
            background="#24273a"
        ),
        widget.PulseVolume(
            fmt="   {} ",
            margin=0,
            background="#24273a"            
        ), 
        widget.Clock(
            format="   %a %d %B, %Y ",
            background="#363a4f"            
        ),
        widget.Clock(
            format="   %H:%M:%S ",
            background="#24273a"            
        ),
    ],
    25, # height
    background="#1e2030",
    # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
    # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
)

class PowerProfilesDaemon(libqtile.widget.base.ThreadPoolText):
    """A widget to display the current power setting of power-profiles-daemon"""

    def __init__(self, **config):
        base.ThreadPoolText.__init__(self, "", **config)
        self.func = None
        self.current_state = "balanced"
        self.update_interval = 1
        self.mouse_callbacks = {
            "Button1": self.next_state,
            "Button2": self.prev_state
        }

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
        ch = ''

        if "performance" in setting:
            ch = ''
        elif "balanced" in setting:
            ch = ''
        elif "power-saver" in setting:
            ch = ''

        self.current_state = setting
        return f"{ch} {setting}"

bottom_bar_main_screen = bar.Bar(
    [
        widget.CurrentLayout(
            fmt=" {} ",
            background="#24273a",
        ),
        widget.Spacer(),
        PowerProfilesDaemon(
            background="#24273a",
            fmt=" {} ",
        ),
        widget.Backlight(
            backlight_name="intel_backlight",
            format="  {percent:2.0%} ",
        ),
        widget.Battery(
            update_interval=5,
            charge_char=" +",
            discharge_char=" -",
            empty_char=" ",
            full_char=" ",
            format=" {char} {percent:2.0%} ({hour:d}:{min:02d} left) ",
            background="#24273a",
        ),
        widget.Memory(
            format="  {MemUsed:.0f}{mm} ",
        ),
        widget.CPU(
            format="  {load_percent}% ",
            threshold=80,
            foreground_alert="#ed8796",
            background="#24273a",
        ),
        widget.ThermalSensor(
            format='  {temp}{unit} ',
        ),
    ],
    25,
    background="#1e2030"
)

top_bar_other_screen = bar.Bar(
    [
        widget.CurrentLayout(
            fmt=" {} ",
            **DECORATIONS_L
        ),
        widget.TaskList(
            highlight_method="block",
            border="#313284",
            urgent_border="f38ba8",
            margin_x=12,
            margin_y=7,
            padding=3,
            icon_size=26,
            theme_path="/usr/share/icons/Papirus-dark",
            txt_floating="🗗",
            txt_maximized="🗖",
            txt_minimized="🗕", 
            **DECORATIONS_LR
        ),
        widget.PulseVolume(
            fmt="    {}  ",
            device='Built-in Audio Analog Stereo',
            **DECORATIONS_R
        ),
        widget.Clock(
            format="    %H:%M:%S  ",
            **DECORATIONS_R
        ),
        widget.Systray(
            padding=6,
            icon_theme="Papirus-dark",
        #   **DECORATIONS_R,    
        ),
    ],
    38,
    margin=6,
    background="#00000000"
)
