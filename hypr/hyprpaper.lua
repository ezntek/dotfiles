local wallpaper = "debtemple.png"
require("beanpaper").Apply {
    prefix = "/home/ezntek/Pictures/wallpapers",
    monitors = {
        { "LVDS-1",   wallpaper },
        { "HDMI-A-1", wallpaper },
        { "VGA-1",    wallpaper }
    },
    log = true,
}
