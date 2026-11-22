-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:51:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local MomentsCommon = require(MomentsParent.MomentsCommon)
local React = require(MomentsParent.React)
local useSignalState = require(MomentsParent.SignalsReact).useSignalState

local InExperienceDetailsPromptContainer = require(MomentsParent.InExperienceDetailsPrompt.InExperienceDetailsPromptContainer)

local getExperienceDetailsSheetStore = require(script.Parent.getExperienceDetailsSheetStore)
local useHideTabBarWhileOpen = require(script.Parent.useHideTabBarWhileOpen)
local useJoinExperience = require(Moments.ExperienceDetailsSheet.Join.useJoinExperience)

local FFlagMomentsFixRecommendationImpressionLifecycle = require(Moments.Flags.FFlagMomentsFixRecommendationImpressionLifecycle)
local FFlagMomentsTabsBehindModalScrim = require(Moments.Flags.FFlagMomentsTabsBehindModalScrim)
local FFlagMomentsNavigationEvent = require(Moments.Flags.FFlagMomentsNavigationEvent)
local FFlagMomentsPlayEvent = require(Moments.Flags.FFlagMomentsPlayEvent)
local NavigationDestinationType = require(Moments.Enums.NavigationDestinationType)

local Analytics = MomentsCommon.Analytics
local EventNames = Analytics.EventNames
local fireAnalyticsEvent = Analytics.fireAnalyticsEvent

return React.memo(function() -- name: ExperienceDetailsSheet
    local experienceDetailsSheetStore = getExperienceDetailsSheetStore(false)
    local var1 = useSignalState(experienceDetailsSheetStore.getIsOpen)

    local var2 = useSignalState(experienceDetailsSheetStore.getContext)
    local var3 = useJoinExperience()

    if not FFlagMomentsTabsBehindModalScrim then
        useHideTabBarWhileOpen(var1)
    end

    React.useEffect(function()
        if not var1 or not var2 then
            return
        end

        if var2.feedItemId ~= nil and var2.feedItemId ~= "" then
            fireAnalyticsEvent(EventNames.ExperienceDetailsOpened, {
                feedItemId = var2.feedItemId,
                feedSessionId = var2.tracingId or "",
                placeId = tostring(var2.placeId),
                universeId = tostring(var2.universeId)
            })
            return
        end

        local str1 = if var2.feedItemId == nil then "nil" else "empty"
        Analytics.reportMomentSkip("feed_action", str1, { action = "edp" })
    end, { var1, var2 })

    local onJoin = React.useCallback(function(num1: number?)
        if var2 then
            local var4 = if FFlagMomentsFixRecommendationImpressionLifecycle and var2.onBeforeJoin ~= nil then var2.onBeforeJoin(if FFlagMomentsNavigationEvent then NavigationDestinationType.ExperienceJoin else nil) else nil
            local var5 = var3
            local var6 = var2

            if not FFlagMomentsPlayEvent then
                var4 = nil
            end

            var5(var6, num1, var4)
        end
        experienceDetailsSheetStore.close()
    end, { var3, var2, experienceDetailsSheetStore.close })

    if not var1 or var2 == nil then
        return nil
    end

    return React.createElement(
        InExperienceDetailsPromptContainer,
        {
            universeId = tostring(var2.universeId),
            onClose = experienceDetailsSheetStore.close,
            onJoin = onJoin
        }
    )
end)
