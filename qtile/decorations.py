from qtile_extras.widget.decorations import *

DECORATIONS_R = {
    "decorations": [
        RectDecoration(colour="#1e1e2e", radius=16, filled=True, padding=3),
        RectDecoration(line_width=3, colour="#cba6f7", padding=3, radius=17),
    ],
    "foreground": "#cdd6f4", 
    "font": "Iosevka Dlig SS20",
    "fontsize": 15,
}

DECORATIONS_L = {
    "decorations": [
        RectDecoration(colour="#1e1e2e", line_width=3, radius=16, filled=True, padding=3),    
        RectDecoration(line_width=3, colour="#cba6f7", padding=3, radius=17),
    ],
    "foreground": "#cdd4f4",
    "font": "Iosevka Dlig SS20",
    "fontsize": 15,
}

DECORATIONS_LR = {
    "decorations": [
        RectDecoration(colour="#1e1e2e", radius=16, filled=True, padding=3),
        RectDecoration(line_width=3, colour="#cba6f7", padding=3, radius=17),
     ],
    "foreground": "#cdd6f4",
}
