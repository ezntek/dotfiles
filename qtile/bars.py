from decorations import * 

from libqtile import bar
from qtile_extras import widget

top_bar_main_screen = bar.Bar(
    [
        widget.GroupBox(
            urgent_border="f38ba8",
            inactive="#6c7086",
            highlight_method="block",
            padding=2,
            margin_x=10,
            margin_y=3,
            this_screen_border="#585b70",
            this_current_screen_border="#585b70",
            other_screen_border="#45475a",
            other_current_screen_border="#45475a",
            disable_drag=True,
            **DECORATIONS_L
        ),
        widget.Prompt(
            **DECORATIONS_L
        ),
        widget.TaskList(
            highlight_method="block",
            border="#313244",
            urgent_border="f38ba8",
            margin_x=10,
            margin_y=6,
            padding=4,
            icon_size=29,
            **DECORATIONS_LR
        ),
        widget.PulseVolume(
            fmt="   {} ",
            cardid=99,
            margin=3,
            **DECORATIONS_R
        ), 
        widget.Clock(
            format="   %a %d %B, %Y ",
            **DECORATIONS_R
        ),
        widget.Clock(
            format="   %H:%M:%S ",
            **DECORATIONS_R
        ),
    ],
    40, # height
    margin=6, 
    background="#00000000",
    # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
    # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
)

bottom_bar_main_screen = bar.Bar(
    [
        widget.CurrentLayout(
            fmt=" {} ",
            **DECORATIONS_L
        ),
        widget.Spacer(**DECORATIONS_LR),
        widget.Memory(
            format="   {MemUsed:.0f}{mm} ",
            **DECORATIONS_R
        ),
        widget.CPU(
            format="   {load_percent}% ",
            **DECORATIONS_R
        ),
        widget.ThermalSensor(
            format='  {temp}{unit} ',
            **DECORATIONS_R
        ),
    ],
    40,
    margin=6,
    background="#1e1e2e00"
)

top_bar_other_screen = bar.Bar(
    [
        widget.CurrentLayout(
            fmt=" {} ",
            **DECORATIONS_L
        ),
        widget.TaskList(
            highlight_method="block",
            urgent_border="#f38ba8",
            border="#313244",
            margin_x=10,
            margin_y=6,
            padding=4,
            icon_size=29,
            **DECORATIONS_LR
        ),
        widget.PulseVolume(
            fmt="   {} ",
            **DECORATIONS_R
        ),
        widget.Clock(
            format="   %H:%M:%S ",
            **DECORATIONS_R
        ),
        widget.Systray(
            padding=6,
            icon_theme="Papirus-dark"
        ),
    ],
    40,
    margin=6,
    background="#00000000"
)
