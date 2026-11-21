-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:20:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")
local WidgetListBreakPointEnum = require(AvatarExperienceCatalog.Components.ResultsList.WidgetListBreakPointEnum)
local WidgetListBreakPointThresholds = require(AvatarExperienceCatalog.Components.ResultsList.WidgetListBreakPointThresholds)

local function getBreakpointFromRowWidth(num1: number?, num2: number?)
    local num3 = num2 or 1

    if not num1 then
        return WidgetListBreakPointEnum.Default
    end

    if num1 <= WidgetListBreakPointThresholds.XSmall * num3 then
        return WidgetListBreakPointEnum.XSmall
    end

    if num1 <= WidgetListBreakPointThresholds.Small * num3 then
        return WidgetListBreakPointEnum.Small
    end

    if num1 <= WidgetListBreakPointThresholds.Medium * num3 then
        return WidgetListBreakPointEnum.Medium
    end

    if num1 <= WidgetListBreakPointThresholds.Large * num3 then
        return WidgetListBreakPointEnum.Large
    end

    if num1 <= WidgetListBreakPointThresholds.XLarge * num3 then
        return WidgetListBreakPointEnum.XLarge
    end

    return WidgetListBreakPointEnum.X2Large
end

return getBreakpointFromRowWidth
