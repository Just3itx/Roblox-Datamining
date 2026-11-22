-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T17:51:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCarouselParent = script:FindFirstAncestor("SocialCarousel").Parent
local React = require(SocialCarouselParent.React)
local Cryo = require(SocialCarouselParent.Cryo)
local useLoadingTimers = require(SocialCarouselParent.SocialLuaAnalytics).Analytics.Timing.useLoadingTimers

return function(callback: (...any) -> (...any))
    local var1 = useLoadingTimers({})
    local var2 = React.useRef({})

    local onSuccessfulRender = React.useCallback(function(str1: string)
        if var2.current[str1] then
            return
        end

        var2.current = Cryo.Dictionary.join(var2.current, { [str1] = true })

        local time = var1.getTime("carouselLoadingTime")
        callback(str1, time)
    end, {})

    React.useEffect(function()
        var1.start("carouselLoadingTime")
    end, {})

    return { onSuccessfulRender = onSuccessfulRender }
end
