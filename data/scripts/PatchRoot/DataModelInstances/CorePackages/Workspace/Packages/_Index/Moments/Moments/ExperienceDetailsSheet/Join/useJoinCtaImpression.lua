-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:51:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local React = require(MomentsParent.React)
local Signals = require(MomentsParent.Signals)
local SignalsReact = require(MomentsParent.SignalsReact)

local MomentsCommon = require(MomentsParent.MomentsCommon)
local VerticalPager = require(Moments.Components.VerticalPager)
local useMomentsSession = require(Moments.Stores.GetMomentsStore.MomentsSessionContext).useMomentsSession
local makeJoinImpressionFields = require(Moments.Analytics.makeJoinImpressionFields)
local MomentImpressionMemory = require(Moments.Components.Feed.Items.Moment.MomentImpressionMemory)
local FFlagMomentsFixOverlayRemountImpressions = require(Moments.Flags.FFlagMomentsFixOverlayRemountImpressions)

local Analytics = MomentsCommon.Analytics
local EventNames = Analytics.EventNames

local useSignalState = SignalsReact.useSignalState
local useVerticalPager = VerticalPager.useVerticalPager
local usePagerItem = VerticalPager.usePagerItem

local function useJoinCtaImpression(bool1: boolean, bool2: boolean)
    local var1 = useVerticalPager()
    local var2 = usePagerItem()
    local var3 = useMomentsSession()

    local item = var2.item

    local var4 = React.useMemo(function()
        return Signals.createComputed(function(arg1): boolean
            return not (item == nil) and var1.store.getCurrentItem(arg1) == item
        end)
    end, { var1, item })

    local current = useSignalState(var4)
    local var6 = if FFlagMomentsFixOverlayRemountImpressions then MomentImpressionMemory.useImpressionRef("joinCta") else React.useRef(false)

    React.useEffect(function()
        local current2 = var6.current
        var6.current = current

        if not bool2 or bool1 or not current or current2 or item == nil or item.kind ~= "moment" then
            return
        end

        local joinImpressionFields = makeJoinImpressionFields(item.moment, var3.getSessionSource(false))
        if joinImpressionFields ~= nil then
            Analytics.fireAnalyticsEvent(EventNames.FeedExperienceJoinImpression, joinImpressionFields)
        end
    end, {
        current,
        bool2,
        bool1,
        item,
        var3
    })
end
return useJoinCtaImpression
