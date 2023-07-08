from decorations import * 

from libqtile import bar
from qtile_extras import widget

top_bar_main_screen = bar.Bar(
    [
        widget.GroupBox(
            urgent_border="f38ba8",
            inactive="#6c7086",
            padding=2,
            margin_x=13,
            margin_y=3,
            this_screen_border="#cba6f7",
            this_current_screen_border="#cba6f7",
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
            margin_x=12,
            margin_y=7,
            padding=3,
            icon_size=29,
            **DECORATIONS_LR
        ),
        #widget.StatusNotifier(
        #    icon_size=20,
        #    icon_theme="Papirus-dark",
        #    padding=10,
        #    menu_font="Rubik",
        #    menu_fontsize=12,
        #    menu_background="11111e",
        #    highlight_colour="cba6f7",
        #    **DECORATIONS_R,
        #),
        widget.PulseVolume(
            fmt="    {}  ",
            cardid=99,
            margin=3,
            **DECORATIONS_R
        ), 
        widget.Clock(
            format="    %a %d %B, %Y  ",
            **DECORATIONS_R
        ),
        widget.Clock(
            format="    %H:%M:%S  ",
            **DECORATIONS_R
        ),
    ],
    38, # height
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
            format="    {MemUsed:.0f}{mm}  ",
            **DECORATIONS_R
        ),
        widget.CPU(
            format="    {load_percent}%  ",
            **DECORATIONS_R
        ),
        widget.ThermalSensor(
            format='   {temp}{unit}  ',
            **DECORATIONS_R
        ),
    ],
    38,
    margin=6,
    background="#11111e00"
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
            fmt="    {}  ",
            **DECORATIONS_R
        ),
        widget.Clock(
            format="    %H:%M:%S  ",
            **DECORATIONS_R
        ),
        widget.Systray(
            padding=6,
            icon_theme="Papirus-dark"
        ),
    ],
    38,
    margin=6,
    background="#00000000"
)
