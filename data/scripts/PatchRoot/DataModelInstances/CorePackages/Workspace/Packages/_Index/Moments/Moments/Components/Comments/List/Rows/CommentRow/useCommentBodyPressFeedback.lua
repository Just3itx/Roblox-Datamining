-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:51:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local Foundation = require(MomentsParent.Foundation)
local React = require(MomentsParent.React)
local ReactOtter = require(MomentsParent.ReactOtter)

local FFlagMomentsCommentRowRedesign = require(Moments.Flags.FFlagMomentsCommentRowRedesign)
local getColorStyleWithTransparency = require(Moments.Utils.getColorStyleWithTransparency)

local ControlState = Foundation.Enums.ControlState
local useTokens = Foundation.Hooks.useTokens

local tbl1 = {
    duration = 0.08,
    easingStyle = Enum.EasingStyle.Quad
}
local tbl2 = {
    duration = 0.15,
    easingStyle = Enum.EasingStyle.Quad
}

local function isFadingState(current): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return current == ControlState.Hover or current == ControlState.Pressed
end

local function useCommentBodyPressFeedback(str1: string, current: boolean)
    local var1 = useTokens()
    local var2, var3 = ReactOtter.useAnimatedBinding(0)
    local var4 = React.useRef(ControlState.Default)
    local var5 = React.useRef(current)

    React.useLayoutEffect(function()
        var5.current = current

        local bool2 = current and isFadingState(var4.current)
        var3((ReactOtter.instant(if bool2 then 1 else 0)))
    end, { str1, current })

    local onStateChanged = React.useCallback(function(current2)
        var4.current = current2
        if var5.current then
            local bool2 = isFadingState(current2)
            var3(ReactOtter.ease(if bool2 then 1 else 0, if bool2 then tbl1 else tbl2))
        end
    end, { var3 })

    local var7 = if FFlagMomentsCommentRowRedesign then var1.Color.Content.Default else var1.Color.Content.Emphasis

    return {
        onStateChanged = onStateChanged,
        textStyle = React.useMemo(function()
            return var2:map(function(num1: number)
                return getColorStyleWithTransparency(var7, num1 * 0.4)
            end)
        end, { var2, var7 })
    }
end

return useCommentBodyPressFeedback
