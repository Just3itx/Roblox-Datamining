-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:50:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Constants = require(script.Parent.Parent.Constants)

local function computeCutoutFieldOfViewDeg(tbl1): number
    local var1 = tbl1.cameraFieldOfViewDeg or Constants.CameraFieldOfViewDeg
    local viewportHeightPix = tbl1.viewportHeightPix
    local cutoutTopOffsetPix = tbl1.cutoutTopOffsetPix
    local cutoutDiameterPix = tbl1.cutoutDiameterPix

    local num1 = math.rad(var1)
    local var2 = viewportHeightPix / 2 / math.tan(num1 / 2)
    local var3 = viewportHeightPix / 2 - cutoutTopOffsetPix
    local var4 = var3 - cutoutDiameterPix
    return math.deg(math.atan2(var3, var2) - math.atan2(var4, var2))
end

return computeCutoutFieldOfViewDeg
