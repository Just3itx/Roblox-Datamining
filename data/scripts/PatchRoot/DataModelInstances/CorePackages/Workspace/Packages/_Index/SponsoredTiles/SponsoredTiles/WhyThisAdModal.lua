-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T22:00:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SponsoredTiles = script:FindFirstAncestor("SponsoredTiles")
local SponsoredTilesParent = SponsoredTiles.Parent

local CentralOverlay = require(SponsoredTilesParent.CentralOverlay)
local Foundation = require(SponsoredTilesParent.Foundation)
local GameDetailRodux = require(SponsoredTilesParent.GameDetailRodux)
local Http = require(SponsoredTilesParent.Http)
local Loggers = require(SponsoredTilesParent.Loggers)
local Localization = require(SponsoredTilesParent.Localization)
local NavigationRodux = require(SponsoredTilesParent.NavigationRodux)
local React = require(SponsoredTilesParent.React)
local RobloxAppEnums = require(SponsoredTilesParent.RobloxAppEnums)
local RobloxAppHooks = require(SponsoredTilesParent.RobloxAppHooks)
local RoactServiceTags = require(SponsoredTilesParent.RoactServiceTags)
local RoactUtils = require(SponsoredTilesParent.RoactUtils)

local AppPage = RobloxAppEnums.AppPage
local CloseCentralOverlay = CentralOverlay.Thunks.CloseCentralOverlay
local Dialog = Foundation.Dialog
local View = Foundation.View
local Button = Foundation.Button
local ButtonVariant = Foundation.Enums.ButtonVariant
local NavigateDown = NavigationRodux.Thunks.NavigateDown
local FFlagSignalsNavP3Dispatch = require(SponsoredTilesParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(SponsoredTilesParent.RobloxAppNavigation).NavigationCommands else nil
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local useLocalization = Localization.Hooks.useLocalization
local useRoactService = RobloxAppHooks.useRoactService
local flaggedMutedError = Loggers.flaggedMutedError
local RoactNetworking = RoactServiceTags.RoactNetworking
local ApiFetchGameDetails = GameDetailRodux.GameDetails.ApiFetchGameDetails
local RetrievalStatus = Http.Enum.RetrievalStatus
local SponsoredUserCohort = require(SponsoredTiles.Enums.SponsoredUserCohort)
local OmniRecommendationsContentType = require(SponsoredTilesParent.DiscoveryTypes).OmniRecommendationsContentType

local FStringLuaAppAdPreferencesUrl = require(SponsoredTilesParent.SharedFlags).FStringLuaAppAdPreferencesUrl
local FFlagLuaAppEnableNxMRoduxApportioning = require(SponsoredTilesParent.SharedFlags).FFlagLuaAppEnableNxMRoduxApportioning

local function useCreatorName(universeId: string)
    local var1 = useDispatch()
    local var2 = useRoactService(RoactNetworking)

    if not FFlagLuaAppEnableNxMRoduxApportioning then
        local var3 = useSelector(function(arg1)
            return universeId and ApiFetchGameDetails.GetFetchingStatus(arg1, universeId) or nil
        end)

        local var4 = useSelector(function(arg1)
            return universeId and arg1.GameDetails[universeId] or nil
        end)

        React.useEffect(function()
            if universeId and not var4 and var3 ~= RetrievalStatus.Fetching then
                var1(ApiFetchGameDetails.Fetch(var2, { universeId }))
            end
        end, {
            universeId,
            var4,
            var3,
            var1,
            var2
        })
        return var4 and var4.creator and var4.creator.name or nil, var3
    end

    local bool1 = not (universeId == nil) and universeId ~= ""

    local var3 = useSelector(function(arg1)
        return bool1 and ApiFetchGameDetails.GetFetchingStatus(arg1, universeId) or nil
    end)

    local var4 = useSelector(function(arg1)
        return bool1 and arg1.GameDetails[universeId] or nil
    end)

    React.useEffect(function()
        if bool1 and not var4 and var3 ~= RetrievalStatus.Fetching then
            var1(ApiFetchGameDetails.Fetch(var2, { universeId }))
        end
    end, {
        bool1,
        universeId,
        var4,
        var3,
        var1,
        var2
    })
    return var4 and var4.creator and var4.creator.name or nil, var3
end

local function getSponsoredDisclosureTranslationKey(sponsoredUserCohort: string?): string -- Luacid: Inlined by compiler; 1 call site recovered
    if sponsoredUserCohort == SponsoredUserCohort.UnderEighteen then
        return "Feature.GameDetails.Message.SponsoredDisclosure.U18"
    end

    if sponsoredUserCohort == SponsoredUserCohort.EighteenPlusPersonalized then
        return "Feature.GameDetails.Message.SponsoredDisclosure.O18PersonalizedNoLink"
    end

    if sponsoredUserCohort == SponsoredUserCohort.EighteenPlusNonPersonalized then
        return "Feature.GameDetails.Message.SponsoredDisclosure.O18NonPersonalizedNoLink"
    end

    return "Feature.GameDetails.Message.SponsoredDisclosure.U18"
end

local function getSponsoredDisclosureNoUniverseTranslationKey(sponsoredUserCohort: string?): string -- Luacid: Inlined by compiler; 1 call site recovered
    if sponsoredUserCohort == SponsoredUserCohort.UnderEighteen then
        return "Feature.GameDetails.Message.SponsoredDisclosureNoUniverse.U18"
    end

    if sponsoredUserCohort == SponsoredUserCohort.EighteenPlusPersonalized then
        return "Feature.GameDetails.Message.SponsoredDisclosureNoUniverse.O18PersonalizedNoLink"
    end

    if sponsoredUserCohort == SponsoredUserCohort.EighteenPlusNonPersonalized then
        return "Feature.GameDetails.Message.SponsoredDisclosureNoUniverse.O18NonPersonalNoLink"
    end

    return "Feature.GameDetails.Message.SponsoredDisclosureNoUniverse.U18"
end

local function resolveSponsoredDisclosure(payerName: string?, bool1: boolean, bool2: boolean, str1: string?, sponsoredUserCohort: string?, tbl1)
    if payerName == nil or payerName == "" then
        flaggedMutedError("WhyThisAdDisclosureError", "Missing payerName in WhyThisAdModal")
        return tbl1.sponsoredDisclosureError, false
    end

    local bool3 = sponsoredUserCohort == SponsoredUserCohort.EighteenPlusPersonalized
        or sponsoredUserCohort == SponsoredUserCohort.EighteenPlusNonPersonalized

    if bool1 then
        if bool2 then
            flaggedMutedError("WhyThisAdDisclosureError", "Unexpected universeId for AdLink in WhyThisAdModal")
        end
        return tbl1.sponsoredDisclosureNoUniverse, bool3
    end

    if not bool2 then
        flaggedMutedError("WhyThisAdDisclosureError", "Missing universeId in WhyThisAdModal")
        return tbl1.sponsoredDisclosureError, bool3
    end

    if str1 then
        return tbl1.sponsoredDisclosure, bool3
    end

    flaggedMutedError("WhyThisAdDisclosureError", "Missing creatorName in WhyThisAdModal")
    return tbl1.sponsoredDisclosureError, bool3
end

local function WhyThisAdModal(tbl1)
    local var1 = useDispatch()
    local creatorName, var3 = useCreatorName(tbl1.universeId)

    local var4 = useLocalization({
        sponsoredDisclosure = {
            getSponsoredDisclosureTranslationKey(tbl1.sponsoredUserCohort),
            CreatorName = creatorName,
            PayerName = tbl1.payerName
        },
        sponsoredDisclosureError = "Feature.GameDetails.Message.SponsoredDisclosure.Error",
        whyThisAd = "Feature.GameDetails.Label.WhyThisAd",
        adPreferences = "Feature.GameDetails.Message.AdPreferences",
        sponsoredDisclosureNoUniverse = FFlagLuaAppEnableNxMRoduxApportioning
            and {
                getSponsoredDisclosureNoUniverseTranslationKey(tbl1.sponsoredUserCohort),
                PayerName = tbl1.payerName
            }
            or nil
    })

    local onClose = React.useCallback(function()
        var1(CloseCentralOverlay())
    end, { var1 })

    local onActivated = React.useCallback(function()
        var1(CloseCentralOverlay())
        local tbl2 = {
            name = AppPage.GenericWebPage,
            detail = FStringLuaAppAdPreferencesUrl,
            extraProps = {
                title = var4.adPreferences
            }
        }
        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl2))
            return
        end
        var1(NavigateDown(tbl2))
    end, { var1, var4.adPreferences })

    if var3 == RetrievalStatus.NotStarted or var3 == RetrievalStatus.Fetching then
        return nil
    end

    local var7 = nil
    local var8

    if FFlagLuaAppEnableNxMRoduxApportioning then
        local bool1 = tbl1.contentType == OmniRecommendationsContentType.AdLink
        local bool2 = not (tbl1.universeId == nil) and tbl1.universeId ~= ""
        var8, var7 = resolveSponsoredDisclosure(tbl1.payerName, bool1, bool2, creatorName, tbl1.sponsoredUserCohort, var4)
    elseif creatorName and tbl1.payerName then
        var8 = var4.sponsoredDisclosure
        var7 = tbl1.sponsoredUserCohort == SponsoredUserCohort.EighteenPlusPersonalized
            or tbl1.sponsoredUserCohort == SponsoredUserCohort.EighteenPlusNonPersonalized
    else
        flaggedMutedError("WhyThisAdDisclosureError", "Missing creatorName or payerName in WhyThisAdModal")
        var8 = var4.sponsoredDisclosureError
    end

    local createElement = React.createElement
    local root = Dialog.Root
    local tbl2 = { onClose = onClose, hasBackdrop = true }

    local tbl3 = {
        DialogTitle = React.createElement(Dialog.Title, { text = var4.whyThisAd }),
        DialogContent = 0
    }

    local createElement2 = React.createElement
    local content = Dialog.Content
    local tbl4 = { LayoutOrder = 1 }

    local tbl5 = {
        ContentView = React.createElement(View, { tag = "col auto-xy gap-small" }, {
            DialogText = React.createElement(Dialog.Text, { Text = var8, LayoutOrder = 1 }),
            AdPreferences = if var7 then React.createElement(
                Button,
                {
                    text = var4.adPreferences,
                    variant = ButtonVariant.Text,
                    onActivated = onActivated,
                    LayoutOrder = 2
                }
            ) else nil
        })
    }
    tbl3.DialogContent = createElement2(content, tbl4, tbl5)
    return createElement(root, tbl2, tbl3)
end

return WhyThisAdModal
