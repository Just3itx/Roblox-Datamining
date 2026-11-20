-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:50:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)
local ReactIs = require(FoundationParent.ReactIs)
local ReactOtter = require(FoundationParent.ReactOtter)

local _Types = require(Foundation.Components.Types)
local getDisabledStyle = require(Foundation.Utility.getDisabledStyle)
local mapBindable = require(Foundation.Utility.mapBindable)
local usePreferences = require(Foundation.Providers.Preferences.usePreferences)
local useTokens = require(Foundation.Providers.Style.useTokens)

local function getFraction(num1: number, numberRange: NumberRange) -- Luacid: Inlined by compiler; 3 call sites recovered
    local var1 = numberRange.Max - numberRange.Min
    if var1 <= 0 then
        return 1
    end
    return (math.clamp(num1, numberRange.Min, numberRange.Max) - numberRange.Min) / var1
end

local function getGradientOffset(num1: number): Vector2
    if num1 <= 0 then
        return Vector2.new(-1, 0)
    elseif num1 >= 1 then
        return Vector2.new(1, 0)
    end
    return Vector2.new(num1 - 0.5, 0)
end

local function useInputSliderFill(numberRange: NumberRange, numberRange2: NumberRange, bool1: boolean, tbl1)
    local var1 = useTokens()
    local var2 = usePreferences()

    local var3 = ReactIs.isBinding(numberRange)
    local var4 = if var3 then nil else numberRange
    local var5, var6 = ReactOtter.useAnimatedBinding((getFraction(var4 or 0, numberRange2)))

    React.useEffect(function()
        if var4 == nil then
            return
        end

        local fraction = getFraction(var4, numberRange2)
        if tbl1.current and not var2.reducedMotion then
            var6(ReactOtter.ease(fraction, { easingStyle = var1.Ease.StandardOut, duration = var1.Time.Time_300 }))
        else
            var6((ReactOtter.instant(fraction)))
        end
        tbl1.current = false
    end, {
        var4,
        numberRange2,
        var2.reducedMotion,
        var1
    })
    local offset = React.useMemo(function()
        local var7 = if var3 then mapBindable(numberRange, function(num1: number)
            return getFraction(num1, numberRange2)
        end) else var5

        return mapBindable(var7, getGradientOffset)
    end, {
        var3,
        numberRange,
        numberRange2,
        var5
    })
    local var8 = React.useMemo(function()
        local disabledStyle = getDisabledStyle(var1.Color.Shift.Shift_300, bool1)
        local disabledStyle2 = getDisabledStyle(var1.Color.Shift.Shift_200, bool1)
        return {
            color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, disabledStyle.Color3),
                ColorSequenceKeypoint.new(0.499, disabledStyle.Color3),
                ColorSequenceKeypoint.new(0.5, disabledStyle2.Color3),
                ColorSequenceKeypoint.new(1, disabledStyle2.Color3)
            }),
            transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, disabledStyle.Transparency or 0),
                NumberSequenceKeypoint.new(0.499, disabledStyle.Transparency or 0),
                NumberSequenceKeypoint.new(0.5, disabledStyle2.Transparency or 0),
                NumberSequenceKeypoint.new(1, disabledStyle2.Transparency or 0)
            })
        }
    end, { var1, bool1 })

    return {
        color = var8.color,
        transparency = var8.transparency,
        offset = offset
    }
end

return useInputSliderFill
