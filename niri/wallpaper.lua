local prefix = "/home/ezntek/Nextcloud/Pictures/wallpapers"
local wallpaper = prefix .. "/viaduct_sunset.png"
local outputs = { "LVDS-1" }

for _, v in ipairs(outputs) do
    local s = string.format("swaybg -i %s -o %s", wallpaper, v)
    os.execute(s)
end
