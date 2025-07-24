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
    local wp = prefix .. "/cathedralbridgesunset.png"
    local outputs = { "DP-1", "HDMI-A-1" }

    for _, output in ipairs(outputs) do
        local s = string.format("swaybg --output %s -i %s --mode center", output, wp)
        _launch_one_bg(s)
    end
end

local function setup_sleep_and_lock()
    local timeout = 300
    local locker = "hyprlock"
    local s = string.format(
        "swayidle -w timeout %d \"niri msg action power-off-monitors\" timeout %d \"%s\" before-sleep \"%s\"",
        timeout + 1,
        timeout,
        locker, locker)
    _launch_one_bg(s)
end

wallpaper()
setup_sleep_and_lock()
launch_bg {
    "waybar",
    "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
}
launch {
    "xwayland-satellite"
}
