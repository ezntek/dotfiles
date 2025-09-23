local function _launch_one_bg(cmd)
    local s = string.format("nohup sh -c '%s' > /dev/null 2>&1 &", cmd)
    print("\27[2mexecuting \"" .. s .. "\"\27[0m")
    os.execute(s)
end

local function _launch_one(cmd)
    os.execute(cmd)
end

local function launch_bg(cmds)
    for _, v in ipairs(cmds) do
        _launch_one_bg(tostring(v))
    end
end

local function launch(cmds)
    for _, v in ipairs(cmds) do
        _launch_one(tostring(v))
    end
end

local function wallpaper()
    local prefix = "/home/ezntek/Nextcloud/Pictures/wallpapers"
    local wp = prefix .. "/korihasiph_park_light.png"
    local outputs = { "eDP-1", "HDMI-A-1" }

    for _, output in ipairs(outputs) do
        local s = string.format("swaybg --output %s -i %s --mode fill", output, wp)
        _launch_one_bg(s)
    end
end

local function setup_sleep_and_lock()
    local timeout = 300
    local locker = "swaylock -f"
    local s = string.format(
        "swayidle -w timeout %d \"%s\" timeout %d \"niri msg action power-off-monitors\" before-sleep \"%s\"",
        timeout,
        locker, timeout, locker)
    _launch_one_bg(s)
end

wallpaper()
setup_sleep_and_lock()
launch_bg {
    "waybar",
    "/usr/libexec/polkit-gnome-authentication-agent-1",
    "/usr/lib/xdg-desktop-portal-gtk",
    "gnome-keyring-daemon",
    "pipewire",
    "dunst",
}
launch {
    "xwayland-satellite",
    "nextcloud"
}
