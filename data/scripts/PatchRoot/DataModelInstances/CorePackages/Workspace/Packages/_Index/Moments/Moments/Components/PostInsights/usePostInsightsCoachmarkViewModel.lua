-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:41:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local Players = game:GetService("Players")

local Localization = require(MomentsParent.Localization)
local MomentsCommon = require(MomentsParent.MomentsCommon)
local _MomentsTypes = require(MomentsParent.MomentsTypes)
local React = require(MomentsParent.React)
local SharedFlags = require(MomentsParent.SharedFlags)
local Signals = require(MomentsParent.Signals)
local SignalsReact = require(MomentsParent.SignalsReact)

local VerticalPager = require(Moments.Components.VerticalPager)
local useFeedOptional = require(Moments.Components.Feed.FeedContext).useFeedOptional
local _createMomentStore = require(Moments.Components.Feed.Items.Moment.createMomentStore)
local firePostInsightsCoachmarkEvent = require(script.Parent.firePostInsightsCoachmarkEvent)
local getPostInsightsCoachmarkSessionStore = require(script.Parent.getPostInsightsCoachmarkSessionStore)
local getPostInsightsPageStore = require(script.Parent.getPostInsightsPageStore)
local postInsightsCoachmarkImpressionCache = require(script.Parent.postInsightsCoachmarkImpressionCache)
local postInsightsStrings = require(script.Parent.postInsightsStrings)
local getCommentsSheetStore = if SharedFlags.FFlagMomentsComments then require(Moments.Components.Comments.Sheet.getCommentsSheetStore) else nil
local EventNames = MomentsCommon.Analytics.EventNames
local RecommendationSource = MomentsCommon.Analytics.RecommendationSource
local GetFIntMomentsCoachmarkMaxImpressions = MomentsCommon.Flags.GetFIntMomentsCoachmarkMaxImpressions
local GetFIntMomentsCoachmarkAutoDismissSeconds = MomentsCommon.Flags.GetFIntMomentsCoachmarkAutoDismissSeconds

local useLocalization = Localization.Hooks.useLocalization

local function onImpression()
    firePostInsightsCoachmarkEvent(EventNames.FTUXTooltipImpression)
end

local function onDismissed()
    firePostInsightsCoachmarkEvent(EventNames.FTUXTooltipDismissed)
end

local function usePostInsightsCoachmarkViewModel(tbl1)
    local var1 = useLocalization(postInsightsStrings.TOOLTIP_KEYS)
    local var2 = useFeedOptional()
    local var3 = VerticalPager.useVerticalPager()
    local item = VerticalPager.usePagerItem().item

    local var4 = React.useMemo(function()
        return Signals.createComputed(function(arg1): boolean
            return not (item == nil) and var3.store.getCurrentItem(arg1) == item
        end)
    end, { var3, item })
    local var5 = SignalsReact.useSignalState(var4)

    local var6 = SignalsReact.useSignalState(getPostInsightsPageStore(false).getIsOpen)
    local var7 = not (getCommentsSheetStore == nil) and SignalsReact.useSignalState(getCommentsSheetStore(false).getIsOpen)
    local bool1

    if var2 == nil or var2.recommendationSource ~= RecommendationSource.Profile or tbl1.momentStore == nil then
        bool1 = false
    else
        bool1 = not tbl1.isDisabled
        bool1 = bool1 and tbl1.moment.creatorId == (if Players.LocalPlayer then Players.LocalPlayer.UserId else nil)
    end

    if bool1 then
        if var5 then
            if var2 == nil then
                var5 = false
            else
                var5 = var2.isActiveFeed
            end
        end
    else
        var5 = bool1
    end
    local var8, var9 = React.useState(false)
    React.useEffect(function()
        if var5 then
            var9(true)
        end
    end, { var5 })

    local var10, var11 = React.useState(false)
    React.useEffect(function()
        if tbl1.isMenuOpen then
            var11(true)
        end
    end, { tbl1.isMenuOpen })

    local postInsightsCoachmarkSessionStore = getPostInsightsCoachmarkSessionStore(false)

    return {
        shouldMount = bool1 and (var5 or var8),
        hidden = not var5 or tbl1.isMenuOpen or var10 or var7 or var6,
        title = var1.title,
        text = var1.text,
        impressionCache = postInsightsCoachmarkImpressionCache,
        maxImpressions = GetFIntMomentsCoachmarkMaxImpressions(),
        autoDismissSeconds = GetFIntMomentsCoachmarkAutoDismissSeconds(),
        isSessionHandled = postInsightsCoachmarkSessionStore.getIsHandled(false),
        onSessionHandled = postInsightsCoachmarkSessionStore.markHandled,
        onImpression = onImpression,
        onDismissed = onDismissed
    }
end

return usePostInsightsCoachmarkViewModel
