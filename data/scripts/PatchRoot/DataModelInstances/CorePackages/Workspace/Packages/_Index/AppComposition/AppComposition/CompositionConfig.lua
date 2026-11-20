-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:31:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppComposition = script:FindFirstAncestor("AppComposition")
local AppCompositionParent = AppComposition.Parent

local Breakpoint = require(AppCompositionParent.Foundation).Enums.Breakpoint

local _AppCompositionTypes = require(AppComposition.AppCompositionTypes)
local AppCompositionEnums = require(AppComposition.AppCompositionEnums)

local FFlagEnableSplitPane = require(AppCompositionParent.SharedFlags).FFlagEnableSplitPane

local RegionName = AppCompositionEnums.RegionName

local function getRegionOverrides(supportRegion): {minWidth: number, widthScale: number}? -- Luacid: Inlined by compiler; 1 call site recovered
    return if supportRegion == RegionName.SupportRegion then { widthScale = 0.33, minWidth = 355 } else nil
end

local function getBaseConfig(arg1, arg2)
    if arg1 == Breakpoint.XSmall then
        local size300 = arg2.Size.Size_300
        return {
            margin = size300,
            gutter = arg2.Gutter.Small,
            columns = 3,
            carouselPeek = 2 * size300
        }
    end

    if arg1 == Breakpoint.Small then
        local small = arg2.Margin.Small
        return {
            margin = small,
            gutter = arg2.Gutter.Medium,
            columns = 6,
            carouselPeek = 2 * small
        }
    end

    if arg1 == Breakpoint.Medium then
        return {
            margin = arg2.Size.Size_800,
            gutter = arg2.Gutter.Large,
            columns = 12,
            carouselPeek = 0
        }
    end

    if arg1 == Breakpoint.Large then
        return {
            margin = arg2.Size.Size_800,
            gutter = arg2.Gutter.Large,
            columns = 12,
            carouselPeek = 0
        }
    end

    if arg1 == Breakpoint.XLarge then
    end

    return {
        margin = arg2.Size.Size_1600,
        gutter = arg2.Gutter.XLarge,
        columns = 12,
        carouselPeek = 0
    }
end

local function resolveLayout(arg1, arg2) -- Luacid: Inlined by compiler; 1 call site recovered
    return (getBaseConfig(arg1, arg2))
end

local function getRegionLayout(supportRegion, arg1, arg2)
    local var1 = resolveLayout(arg1, arg2)
    local regionOverrides = getRegionOverrides(supportRegion)

    if regionOverrides then
        var1.width = regionOverrides.width
        var1.widthScale = regionOverrides.widthScale
        var1.minWidth = regionOverrides.minWidth
        var1.maxWidth = regionOverrides.maxWidth
    end
    return var1
end

local tbl1 = {
    getBaseConfig = getBaseConfig,
    resolveLayout = if FFlagEnableSplitPane then resolveLayout else nil,
    getRegionOverrides = if FFlagEnableSplitPane then getRegionOverrides else nil,
    getRegionLayout = 0
}

if not FFlagEnableSplitPane then
    getRegionLayout = nil
end

tbl1.getRegionLayout = getRegionLayout
return tbl1
