-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T14:10:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsCarouselParent = script:FindFirstAncestor("FriendsCarousel").Parent

local React = require(FriendsCarouselParent.React)
local UIBlox = require(FriendsCarouselParent.UIBlox)
local RobloxAppHooks = require(FriendsCarouselParent.RobloxAppHooks)
local SocialLuaAnalytics = require(FriendsCarouselParent.SocialLuaAnalytics)

local useLocalUserId = RobloxAppHooks.useLocalUserId
local useLoadingTimers = SocialLuaAnalytics.Analytics.Timing.useLoadingTimers
local RetrievalStatus = UIBlox.App.Loading.Enum.RetrievalStatus

local AnalyticsSetup = require(script.Parent.AnalyticsSetup)
local EventNames = require(script.Parent.EventNames)
local UILoadingEvents = require(script.Parent.UILoadingEvents)

local function CarouselWithLoadingTimer(tbl1)
    local var1 = useLocalUserId()
    local var2 = useLoadingTimers({})
    local var3 = React.useRef({})

    local var4 = React.useMemo(function()
        return AnalyticsSetup({ infoForAllEvents = { uid = if var1 then tostring(var1) else nil } })
    end, { var1 })

    React.useEffect(function()
        var2.start("carouselLoadingTime")
    end, {})

    local function func1(fetch: string, time: number)
        local loadingTime = time and typeof(time) == "number" and not (time < 0) and time or 0

        var4.fireAnalyticsEvent(
            EventNames.FriendsCarouselUILoadingTime,
            {
                loadingTime = loadingTime,
                fetch = fetch,
                status = RetrievalStatus.Done.rawValue()
            }
        )
    end
    return tbl1.renderComponent({
        onSuccessfulRender = function(fetch: string)
            if not (var3.current[UILoadingEvents.EmptyHint]
                or var3.current[`{UILoadingEvents.EmptyHint}{UILoadingEvents.ExperimentSuffix}`])
                and fetch
                and not var3.current[fetch]
            then
                var3.current[fetch] = true

                local time = var2.getTime("carouselLoadingTime")
                func1(fetch, time)
            end
        end
    })
end

return CarouselWithLoadingTimer
