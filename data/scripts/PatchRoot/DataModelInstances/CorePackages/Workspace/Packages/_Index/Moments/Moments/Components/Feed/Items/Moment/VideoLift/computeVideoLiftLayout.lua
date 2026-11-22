-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:21:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local MomentsCommon = require(MomentsParent.MomentsCommon)

local _getCommentsVideoLift = require(Moments.Components.Comments.Sheet.getCommentsVideoLift)

local TweenService = game:GetService("TweenService")

local getFitSize = MomentsCommon.Utils.getFitSize

local Quad = Enum.EasingStyle.Quad

local function getDisplayedHeight(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    local resolution = tbl1.resolution

    if tbl1.scaleType == Enum.ScaleType.Fit and resolution ~= nil then
        return tbl1.itemSize.Y * getFitSize(tbl1.itemSize, resolution).Y.Scale
    end

    return tbl1.itemSize.Y
end

local function computeVideoLiftLayout(tbl1)
    local lift = tbl1.lift
    local itemSize = tbl1.itemSize
    if lift.progress <= 0 or itemSize.X <= 0 or itemSize.Y <= 0 then
        return nil
    end

    local var1 = lift.bandTop + tbl1.padding
    local var2 = lift.bandBottom - tbl1.padding - var1
    if var2 <= 0 then
        return nil
    end

    local num1 = math.min(var2 / getDisplayedHeight(tbl1), 1)
    local var3 = var1 + var2 / 2 - (tbl1.itemTop + itemSize.Y / 2)
    local value = TweenService:GetValue(math.min(lift.progress, 1), Quad, Enum.EasingDirection.In)
    return {
        scale = 1 + (num1 - 1) * value,
        offsetY = var3 * value,
        cornerRadius = if num1 < 1 then tbl1.cornerRadius * value else 0
    }
end

return computeVideoLiftLayout
