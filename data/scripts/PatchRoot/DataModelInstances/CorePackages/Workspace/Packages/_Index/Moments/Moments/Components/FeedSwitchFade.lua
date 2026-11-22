-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:30:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local Foundation = require(MomentsParent.Foundation)
local React = require(MomentsParent.React)
local ReactOtter = require(MomentsParent.ReactOtter)

local useTokens = Foundation.Hooks.useTokens

local tbl1 = {
    duration = 0.2,
    easingStyle = Enum.EasingStyle.Sine
}

local function FadeCover(tbl2)
    local var1 = useTokens()
    local onFaded = tbl2.onFaded
    local var2, var3 = ReactOtter.useAnimatedBinding(0, function(num1: number)
        if num1 >= 1 then
            onFaded()
        end
    end)

    React.useEffect(function()
        var3((ReactOtter.ease(1, tbl1)))
    end, {})

    local surface0 = var1.Color.Surface.Surface_0
    return React.createElement(Foundation.View, {
        tag = "size-full",
        backgroundStyle = var2:map(function(num1: number)
            return {
                Color3 = surface0.Color3,
                Transparency = math.lerp(surface0.Transparency, 1, num1)
            }
        end),
        testId = "--moments-feed-switch-fade"
    })
end

local function FeedSwitchFade(tbl2)
    local var1, var2 = React.useState(0)
    local var3, var4 = React.useState(0)
    local var5, var6 = React.useState(tbl2.feedKey)

    if var5 ~= tbl2.feedKey then
        var6(tbl2.feedKey)
        var2(var1 + 1)
    end

    local onFaded = React.useCallback(function()
        var4(var1)
    end, { var1 })

    if var3 == var1 then
        return nil
    end

    local tbl3 = {
        [`Cover{var1}`] = React.createElement(FadeCover, { onFaded = onFaded })
    }

    return React.createElement(
        Foundation.View,
        {
            tag = "size-full",
            backgroundStyle = { Transparency = 1 },
            ZIndex = tbl2.ZIndex
        },
        tbl3
    )
end

return FeedSwitchFade
