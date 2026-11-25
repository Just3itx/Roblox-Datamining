-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T21:30:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {
    SpeedAdjustmentTarget = 0.5,
    CursorRadius = 40,
    SelectionRadius = 40,
    OcclusionRadiusScale = 0.7,
    MaxSpeedRelative = 0.7,
    ThumbstickDeadzone = 0.2,
    ScrollingRadius = 15,
    ScrollingSlowDown = 0.25,
    ScrollingSpeed = 1000
}

setmetatable(tbl1, {
    __index = function(_, arg1)
        error(string.format("%q is not a valid member of properties", tostring(arg1)), 2)
    end
})

return tbl1
