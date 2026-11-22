-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:30:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCommon = script:FindFirstAncestor("MomentsCommon")

local resolveMaxCropFraction = require(MomentsCommon.Utils.resolveMaxCropFraction)

local FFlagMomentsSmartVideoFillLandscape = require(MomentsCommon.Flags.FFlagMomentsSmartVideoFillLandscape)
local FIntMomentsMaxVideoCropPercent = require(MomentsCommon.Flags.FIntMomentsMaxVideoCropPercent)

local function getSmartFillScaleType(scaleType, vector2: Vector2, vector2_2: Vector2?, num1: number?)
    if scaleType ~= Enum.ScaleType.Fit or vector2_2 == nil or vector2_2.X == 0 or vector2_2.Y == 0 then
        return scaleType
    end

    local var1 = resolveMaxCropFraction(
        vector2,
        vector2_2,
        num1 or math.clamp(FIntMomentsMaxVideoCropPercent, 0, 100) / 100,
        FFlagMomentsSmartVideoFillLandscape
    )
    if var1 <= 0 then
        return scaleType
    end
    if var1 >= 1 then
        return Enum.ScaleType.Crop
    end

    local var2 = vector2.X / vector2.Y
    local var3 = vector2_2.X / vector2_2.Y
    return if math.max(var2 / var3, var3 / var2) <= 1 / (1 - var1) then Enum.ScaleType.Crop else scaleType
end

return getSmartFillScaleType
