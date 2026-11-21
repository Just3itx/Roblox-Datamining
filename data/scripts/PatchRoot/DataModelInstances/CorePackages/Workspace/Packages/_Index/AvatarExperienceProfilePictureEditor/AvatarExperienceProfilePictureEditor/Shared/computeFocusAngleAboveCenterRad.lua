-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:50:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Constants = require(script.Parent.Parent.Constants)

local function computeFocusAngleAboveCenterRad(tbl1): number
    local num1 = math.rad(tbl1.cameraFieldOfViewDeg or Constants.CameraFieldOfViewDeg)
    local var1 = tbl1.viewportHeightPix / 2 / math.tan(num1 / 2)
    return math.atan2(tbl1.viewportHeightPix / 2 - (tbl1.cutoutTopOffsetPix + tbl1.cutoutDiameterPix / 2), var1)
end

return computeFocusAngleAboveCenterRad
