-- Monitor wiki https://wiki.hypr.land/Configuring/Basics/Monitors/
-- Example: output can be found with hyprctl monitors. Edit variables.lua for the monitor outputs instead of here directly
-- hl.monitor({
--     output    = MONITOR1,
--     mode      = "1920x1080@60",
--     position  = "0x0",
--     scale     = "1",
-- })

-- Ultrawide (left). Its EDID reports 60 Hz as "preferred", so the refresh rate is set explicitly.
-- VRR follows misc.vrr in misc.lua (3 = only for fullscreen games/video, avoids desktop flicker).
hl.monitor({
    output    = MONITOR1,
    mode      = "3440x1440@100",
    position  = "0x0",
    scale     = 1,
})

-- 144 Hz monitor (right). Not VRR-capable over HDMI.
hl.monitor({
    output    = MONITOR2,
    mode      = "2560x1440@144",
    position  = "3440x0",
    scale     = 1,
})

-- Fallback for any other monitor that gets plugged in.
hl.monitor({
    output    = "",
    mode      = "preferred",
    position  = "auto",
    scale     = "auto",
})
