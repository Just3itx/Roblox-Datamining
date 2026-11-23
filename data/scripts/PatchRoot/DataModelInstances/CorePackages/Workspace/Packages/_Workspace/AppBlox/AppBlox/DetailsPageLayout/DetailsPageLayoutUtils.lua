-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:21:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function computeContentTopOffset(num1: number, num2: number, num3: number): number -- Luacid: Inlined by compiler; 3 call sites recovered
    if num1 <= 0 then
        return 0
    end
    return math.max(0, num1 / num2 - num3)
end

local function computeInitialScrollY(num1: number, num2: number, num3: number, num4: number): number -- Luacid: Inlined by compiler; 1 call site recovered
    return math.max(0, computeContentTopOffset(num1, num2, num3) - num4)
end

local function computeCanvasPaddingTop(num1: number, bool1: boolean, num2: number, num3: number): number -- Luacid: Inlined by compiler; 1 call site recovered
    local num4 = math.max(0, num1 - (if bool1 then num2 else 0))
    if num4 == 0 then
        num4 = num3
    end

    return num4
end

return {
    computeContentTopOffset = computeContentTopOffset,
    computeInitialScrollY = computeInitialScrollY,
    computeInitialScrollYForSize = function(vector2: Vector2, tbl1): number
        local fullBleedAspectRatio = tbl1.fullBleedAspectRatio
        local headerBarHeight = tbl1.headerBarHeight
        local fullBleedOverlapOffset = tbl1.fullBleedOverlapOffset
        local hasFullBleed = tbl1.hasFullBleed
        local bannerBottomVisiblePercent = tbl1.bannerBottomVisiblePercent

        local var1 = vector2.X / fullBleedAspectRatio
        local var2 = if bannerBottomVisiblePercent ~= nil then math.max(0, math.floor(var1 - bannerBottomVisiblePercent * var1)) else computeInitialScrollY(vector2.X, fullBleedAspectRatio, headerBarHeight, fullBleedOverlapOffset)
        return math.min(
            var2,
            math.max(
                0,
                math.min(
                    computeCanvasPaddingTop(
                        computeContentTopOffset(vector2.X, fullBleedAspectRatio, headerBarHeight),
                        hasFullBleed,
                        fullBleedOverlapOffset,
                        headerBarHeight
                    ),
                    vector2.Y * 0.75
                ) - headerBarHeight
            )
        )
    end,
    computeCanvasPaddingTop = computeCanvasPaddingTop,
    getNoBannerFadeParams = function(num1: number): number
        return math.max(60, num1 * 1.5)
    end,
    getHeaderFadeParams = function(num1: number, num2: number, num3: number): (number, number)
        local num4 = math.max(0, num1 - num3)
        local bool1 = num2 > 0 and num2 < num1
        local var1 = if bool1 then math.max(1, num2 - num4) else math.max(1, (num1 - num4) / 3)
        return num4, var1
    end,
    shouldShowStickyBar = function(num1: number, num2: number, num3: number, num4: number): boolean
        local bool1 = num3 + num4 <= num1
        return num2 < num1 or bool1
    end
}
