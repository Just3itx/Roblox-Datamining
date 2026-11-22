-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:51:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local Foundation = require(MomentsParent.Foundation)
local React = require(MomentsParent.React)
local SignalsReact = require(MomentsParent.SignalsReact)

local Button = Foundation.Button

local useSignalState = SignalsReact.useSignalState

local _Types = require(Moments.ExperienceDetailsSheet.Types)
local FeedContext = require(Moments.Components.Feed.FeedContext)
local useJoinExperience = require(script.Parent.useJoinExperience)
local useJoinCtaImpression = require(script.Parent.useJoinCtaImpression)
local GetMomentsPreferencesStore = require(Moments.Stores.GetMomentsPreferencesStore)

local FFlagMomentsFixRecommendationImpressionLifecycle = require(Moments.Flags.FFlagMomentsFixRecommendationImpressionLifecycle)
local NavigationDestinationType = require(Moments.Enums.NavigationDestinationType)
local FFlagMomentsNavigationEvent = require(Moments.Flags.FFlagMomentsNavigationEvent)
local FFlagMomentsPlayEvent = require(Moments.Flags.FFlagMomentsPlayEvent)

return React.memo(function(tbl1) -- name: JoinButton
    local var1 = useJoinExperience()
    local var2 = useSignalState(GetMomentsPreferencesStore(false).getIsTeleporting)

    useJoinCtaImpression(tbl1.isDisabled == true, tbl1.reportsImpression == true)
    local var3 = if FFlagMomentsFixRecommendationImpressionLifecycle then FeedContext.useFeedOptional() else nil

    local context = tbl1.context

    return React.createElement(Button, {
        LayoutOrder = tbl1.LayoutOrder,
        text = tbl1.text,
        size = Foundation.Enums.InputSize.Medium,
        variant = Foundation.Enums.ButtonVariant.Emphasis,
        isDisabled = tbl1.isDisabled == true or var2,
        testId = tbl1.testId,
        onActivated = function()
            local var4 = if FFlagMomentsFixRecommendationImpressionLifecycle and var3 ~= nil then var3.flushView(if FFlagMomentsNavigationEvent then NavigationDestinationType.ExperienceJoin else nil) else nil
            local var5 = var1
            local var6 = context
            local var7 = nil

            if not FFlagMomentsPlayEvent then
                var4 = nil
            end

            var5(var6, var7, var4)
        end
    })
end)
