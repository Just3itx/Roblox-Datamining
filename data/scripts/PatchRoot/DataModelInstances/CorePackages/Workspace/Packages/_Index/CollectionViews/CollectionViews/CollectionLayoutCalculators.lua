-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:10:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CollectionViews = script:FindFirstAncestor("CollectionViews")
local CollectionViewsParent = CollectionViews.Parent

local _Style = require(CollectionViewsParent.Style)
local _Foundation = require(CollectionViewsParent.Foundation)

local Responsive = require(CollectionViewsParent.Responsive)
local hasExtraPlatformInset = Responsive.HardwareSafeAreaInsets.hasExtraPlatformInset

local ArgCheck = require(CollectionViewsParent.ArgCheck)
local calculateNumColumns = require(CollectionViews.calculateNumColumns)
local CollectionItemSize = require(CollectionViews.CollectionViewTypes).CollectionItemSize

local num1 = game:DefineFastInt("XSmallCollectionItemMinItemCount", 3)
local num2 = game:DefineFastInt("XSmallCollectionItemMaxItemCount", 20)
local num3 = game:DefineFastInt("XSmallCollectionItemMinItemWidth", 100)
local num4 = game:DefineFastInt("XSmallCollectionItemVerticalGap", 16)
local num5 = game:DefineFastInt("XSmallCollectionItemFractionalPercent", 15)

local num6 = game:DefineFastInt("SmallCollectionItemMinItemCount", 3)
local num7 = game:DefineFastInt("SmallCollectionItemMaxItemCount", 12)
local num8 = game:DefineFastInt("SmallCollectionItemMinItemWidth", 150)
local num9 = game:DefineFastInt("SmallCollectionItemVerticalGap", 16)
local num10 = game:DefineFastInt("SmallCollectionItemFractionalPercent", 15)

local num11 = game:DefineFastInt("MediumCollectionItemMinItemCount", 2)
local num12 = game:DefineFastInt("MediumCollectionItemMaxItemCount", 6)
local num13 = game:DefineFastInt("MediumCollectionItemMinItemWidth", 233)
local num14 = game:DefineFastInt("MediumCollectionItemVerticalGap", 16)
local num15 = game:DefineFastInt("MediumCollectionItemFractionalPercent", 15)

local num16 = game:DefineFastInt("LargeCollectionItemMinItemCount", 1)
local num17 = game:DefineFastInt("LargeCollectionItemMaxItemCount", 4)
local num18 = game:DefineFastInt("LargeCollectionItemMinItemWidth", 300)
local num19 = game:DefineFastInt("LargeCollectionItemVerticalGap", 16)
local num20 = game:DefineFastInt("LargeCollectionItemFractionalPercent", 30)

local num21 = game:DefineFastInt("XLargeCollectionItemMinItemCount", 1)
local num22 = game:DefineFastInt("XLargeCollectionItemMaxItemCount", 1)
local num23 = game:DefineFastInt("XLargeCollectionItemMinItemWidth", 300)
local num24 = game:DefineFastInt("XLargeCollectionItemVerticalGap", 16)
local num25 = game:DefineFastInt("XLargeCollectionItemFractionalPercent", 10) / 100
local num26 = num20 / 100
local num27 = num15 / 100
local num28 = num10 / 100
local num29 = num5 / 100

local FFlagLuaAppLayoutParamsInContext = require(CollectionViewsParent.SharedFlags).FFlagLuaAppLayoutParamsInContext

local function scaleSizeForPlatform(num30: number, arg1) -- Luacid: Inlined by compiler; 13 call sites recovered
    return num30 * (if FFlagLuaAppLayoutParamsInContext then arg1.Config.UI.Scale else arg1.Stroke.Standard)
end

local function getLegacySideMargin(num30: number, arg1)
    local num31 = 1024
    local var1 = if FFlagLuaAppLayoutParamsInContext then arg1.Config.UI.Scale else arg1.Stroke.Standard

    if num30 < num31 * var1 then
        return if FFlagLuaAppLayoutParamsInContext then arg1.Padding.Medium else arg1.Size.Size_300
    end

    local num32 = 1280
    local var2 = if FFlagLuaAppLayoutParamsInContext then arg1.Config.UI.Scale else arg1.Stroke.Standard

    if num30 < num32 * var2 then
        return scaleSizeForPlatform(18, arg1)
    end

    local num33 = 1440
    local var3 = if FFlagLuaAppLayoutParamsInContext then arg1.Config.UI.Scale else arg1.Stroke.Standard

    if num30 < num33 * var3 then
        return if FFlagLuaAppLayoutParamsInContext then arg1.Margin.Medium else arg1.Size.Size_600
    end

    local num34 = 1920
    local var4 = if FFlagLuaAppLayoutParamsInContext then arg1.Config.UI.Scale else arg1.Stroke.Standard

    if num30 < num34 * var4 then
        return scaleSizeForPlatform(34, arg1)
    end

    local num35 = 2260
    local var5 = if FFlagLuaAppLayoutParamsInContext then arg1.Config.UI.Scale else arg1.Stroke.Standard

    if num30 < num35 * var5 then
        return scaleSizeForPlatform(38, arg1)
    end

    return if FFlagLuaAppLayoutParamsInContext then arg1.Margin.Large else arg1.Size.Size_1200
end

local function getLegacyColumnGap(num30: number, arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if num30 < 1024 then
        if FFlagLuaAppLayoutParamsInContext then
            return arg1.Gap.Medium
        end

        return arg1.Size.Size_300
    end

    if num30 < 1280 then
        return 18
    end

    if FFlagLuaAppLayoutParamsInContext then
        return arg1.Gap.XXLarge
    end

    return arg1.Size.Size_600
end

return {
    calculateNumColumns = function(num30: number, num31: number, num32: number, arg1, arg2) -- name: calculateNumColumnsForCollection
        local var1, var2, var3

        if arg1 == CollectionItemSize.XLarge then
            var1 = scaleSizeForPlatform(num23, arg2)
            var2 = num21
            var3 = num22
        elseif arg1 == CollectionItemSize.Large then
            var1 = scaleSizeForPlatform(num18, arg2)
            var2 = num16
            var3 = num17
        elseif arg1 == CollectionItemSize.Medium then
            var1 = scaleSizeForPlatform(num13, arg2)
            var2 = num11
            var3 = num12
        elseif arg1 == CollectionItemSize.Small then
            ArgCheck.assert(arg1 == CollectionItemSize.Small)
            var1 = scaleSizeForPlatform(num8, arg2)
            var2 = num6
            var3 = num7
        else
            ArgCheck.assert(arg1 == CollectionItemSize.XSmall)
            var1 = scaleSizeForPlatform(num3, arg2)
            var2 = num1
            var3 = num2
        end
        local num33 = num30 - num31 * 2
        return calculateNumColumns(var1, num32, var2, var3, num33)
    end,
    calculateSideMargin = function(_: number, arg1, num30: number)
        if hasExtraPlatformInset() then
            return if FFlagLuaAppLayoutParamsInContext then arg1.Size.Size_1600 else arg1.Size.Size_1600
        end

        return (getLegacySideMargin(num30, arg1))
    end,
    calculateColumnGap = function(_: number, arg1, num30: number)
        return getLegacyColumnGap(num30, arg1)
    end,
    calculateVerticalPadding = function(arg1, arg2)
        if arg2 == CollectionItemSize.XLarge then
            return scaleSizeForPlatform(num24, arg1)
        elseif arg2 == CollectionItemSize.Large then
            return scaleSizeForPlatform(num19, arg1)
        elseif arg2 == CollectionItemSize.Medium then
            return scaleSizeForPlatform(num14, arg1)
        elseif arg2 == CollectionItemSize.Small then
            return scaleSizeForPlatform(num9, arg1)
        end
        return scaleSizeForPlatform(num4, arg1)
    end,
    calculateFractionalItemAmount = function(arg1, directional: string): number
        if arg1 == CollectionItemSize.XLarge then
            if directional == Responsive.Input.Directional then
                return 0
            end

            return num25
        end

        if arg1 == CollectionItemSize.Large then
            if directional == Responsive.Input.Directional then
                return 0
            end

            return num26
        end

        if arg1 == CollectionItemSize.Medium then
            if directional == Responsive.Input.Directional then
                return 0
            end

            return num27
        end

        if arg1 == CollectionItemSize.Small then
            if directional == Responsive.Input.Directional then
                return 0
            end

            return num28
        end

        if directional == Responsive.Input.Directional then
            return 0
        end

        return num29
    end,
    calculateMaxTilesToShow = function(directional: string): number?
        return if directional == Responsive.Input.Directional then 20 else nil
    end,
    calculateLoadMoreThreshold = function(num30: number): number
        return math.max(1000, num30)
    end
}
