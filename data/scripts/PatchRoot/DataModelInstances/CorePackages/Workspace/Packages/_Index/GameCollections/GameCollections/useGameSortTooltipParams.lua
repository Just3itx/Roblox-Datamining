-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:30:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameCollectionsParent = script:FindFirstAncestor("GameCollections").Parent
local React = require(GameCollectionsParent.React)
local useDispatch = require(GameCollectionsParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useLocalization = require(GameCollectionsParent.Localization).Hooks.useLocalization
local CloseCentralOverlay = require(GameCollectionsParent.CentralOverlay).Thunks.CloseCentralOverlay
local Responsive = require(GameCollectionsParent.Responsive)
local usePreferredInput = Responsive.usePreferredInput
local GameTopicIds = require(GameCollectionsParent.DiscoveryTypes).GameTopicIds
local OpenInfoPeekView = require(GameCollectionsParent.DiscoveryRouting).OpenInfoPeekView
local OpenCloseOnlyInteractiveAlert = require(GameCollectionsParent.DiscoveryRouting).OpenCloseOnlyInteractiveAlert

local function isSponsoredSort(arg1, bool1: boolean) -- Luacid: Inlined by compiler; 1 call site recovered
    if bool1 then
        if arg1 and arg1.topicId == GameTopicIds.Sponsored then
            return true
        end
    elseif arg1 and arg1.gameSetTypeId == "27" then
        return true
    end

    return false
end

local function useGameSortTooltipParams(arg1, bool1: boolean, str1: string?)
    local var1 = useDispatch()
    local var2 = useLocalization({
        SponsoredDisclosure = "CoreScripts.Ads.Label.SponsoredAdsDisclosureStatic",
        SponsoredTitle = "CoreScripts.Ads.Label.SponsoredAds"
    })

    local var3 = usePreferredInput()
    local sponsoredDisclosure = var2.SponsoredDisclosure
    local sponsoredTitle = var2.SponsoredTitle
    local bool2 = isSponsoredSort(arg1, bool1)

    if bool2 and str1 == nil then
        str1 = sponsoredDisclosure
    end

    if not bool2 then
        sponsoredTitle = arg1 and arg1.displayName or ""
    end
    return React.useCallback(function()
        if var3 == Responsive.Input.Touch then
            var1(OpenInfoPeekView(sponsoredTitle, str1))
            return
        end
        var1(OpenCloseOnlyInteractiveAlert(sponsoredTitle, str1, function()
            return var1(CloseCentralOverlay())
        end))
    end, { sponsoredTitle, str1, var3 }), str1
end

return useGameSortTooltipParams
