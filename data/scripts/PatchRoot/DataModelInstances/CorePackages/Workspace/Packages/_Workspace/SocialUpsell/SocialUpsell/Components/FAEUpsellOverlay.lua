-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:31:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local SocialUpsell = script:FindFirstAncestor("SocialUpsell")
local SocialUpsellParent = SocialUpsell.Parent

local React = require(SocialUpsellParent.React)
local SharedFlags = require(SocialUpsellParent.SharedFlags)
local useDispatch = require(SocialUpsellParent.RoactUtils).Hooks.RoactRodux.useDispatch

local FoundationCloudAssets = require(SocialUpsellParent.FoundationCloudAssets)
local FIntCommsFAELockTimestamp = require(SocialUpsell.Flag.FIntCommsFAELockTimestamp)
local UpsellOverlay = require(SocialUpsell.Components.UpsellOverlay)
local createCommonOverlayProps = require(SocialUpsell.Utils.createCommonOverlayProps)
local startFacialAgeEstimation = require(SocialUpsell.Thunks.startFacialAgeEstimation)
local UpsellEntrySurfaceType = require(SocialUpsell.Analytics.Enum.UpsellEntrySurfaceType)
local SocialUpsellType = require(SocialUpsell.Enum.SocialUpsellType)
local UpsellComponent = require(SocialUpsell.Analytics.Enum.UpsellComponent)
local FFlagEnableCountdownBadge = require(SocialUpsell.Flag.FFlagEnableCountdownBadge)
local Assets = FoundationCloudAssets.Assets
local preloadAsset = FoundationCloudAssets.preloadAsset

preloadAsset("pictograms/chat_security")
local pictogramsChat_security = Assets["pictograms/chat_security"]
local assetId = pictogramsChat_security and pictogramsChat_security.assetId or nil

local FFlagAddFriendsPageFAEUpsell = SharedFlags.FFlagAddFriendsPageFAEUpsell
local assetId2 = nil
if FFlagAddFriendsPageFAEUpsell then
    preloadAsset("pictograms/lock_closed")
    local pictogramsLockClosed = Assets["pictograms/lock_closed"]
    assetId2 = pictogramsLockClosed and pictogramsLockClosed.assetId or nil
end
local useSocialUpsellOverlayController = require(SocialUpsell.Hooks.useSocialUpsellOverlayController)

local useLocalization = require(SocialUpsellParent.Localization).Hooks.useLocalization
local FFlagEnableAEGIS2CommsFAEUpsell = SharedFlags.FFlagEnableAEGIS2CommsFAEUpsell
local bool1 = game:DefineFastFlag("AEGISPhase2ShowImageOnFAEOverlay", false)
local bool2 = game:DefineFastFlag("ForceAegisPhase2Modal", false)

return function(arg1)
    local var1 = arg1 or {}
    local var2 = useDispatch()
    local var3 = useSocialUpsellOverlayController(var1.isInExperience)
    local var4 = useLocalization({
        ToKeepChattingLetsCheckYourAge = "Feature.FAE.Label.ToKeepChattingLetsCheckYourAge",
        ModalBodyInApp = "Feature.FAE.Label.ModalBodyInApp",
        LetsCheckYourAgeSoYouCanUseChat = "Feature.FAE.Label.LetsCheckYourAgeSoYouCanUseChat",
        ModalBodyInAppV3 = "Feature.FAE.Label.ModalBodyInAppV3",
        YourSafetyMattersLetsCheckYourAge = "Feature.FAE.Label.YourSafetyMattersLetsCheckYourAge",
        YouNeedAnAgeCheckToUseChatThisMakesChatSafer = "Feature.FAE.Label.YouNeedAnAgeCheckToUseChatThisMakesChatSafer",
        ChatWithFriends = if FFlagAddFriendsPageFAEUpsell then "Feature.FAE.Label.ChatWithFriends" else nil,
        GetASecureAgeCheckToUnlockChatAndAddTrustedFriends = if FFlagAddFriendsPageFAEUpsell then "Feature.FAE.Label.GetASecureAgeCheckToUnlockChatAndAddTrustedFriends" else nil,
        Unlock = if FFlagAddFriendsPageFAEUpsell then "Feature.FAE.Action.Unlock" else nil,
        Continue = "Feature.FAE.Action.Continue",
        ThisAllowsYouToChatSafelyItOnlyTakesAMoment = if FFlagEnableAEGIS2CommsFAEUpsell then "Feature.FAE.Label.ThisAllowsYouToChatSafelyItOnlyTakesAMoment" else nil,
        UnlockChat = if FFlagEnableAEGIS2CommsFAEUpsell then "Feature.FAE.Action.UnlockChat" else nil,
        ThisHelpsYouToChatSafelyItOnlyTakesAMoment = "Feature.FAE.Label.ThisHelpsYouToChatSafelyItOnlyTakesAMoment",
        LetsCheckYourAge = "Feature.FAE.Label.LetsCheckYourAge",
        ToAddTrustedFriendDoAgeCheck = "Feature.FAE.Label.ModalBodyTFUnlock"
    })

    local var5 = React.useRef(false)

    local useMemo = React.useMemo
    local function func1()
        if FFlagEnableAEGIS2CommsFAEUpsell and (bool2 or var1.isPhase2) then
            return var4.LetsCheckYourAgeSoYouCanUseChat, var4.ThisHelpsYouToChatSafelyItOnlyTakesAMoment
        elseif var1.upsellEntrySurface == UpsellEntrySurfaceType.Homepage and var1.upsellEntryComponent == UpsellComponent.Modal
            or var1.upsellEntrySurface == UpsellEntrySurfaceType.NotifPush
        then
            return var4.YourSafetyMattersLetsCheckYourAge, var4.YouNeedAnAgeCheckToUseChatThisMakesChatSafer
        elseif FFlagAddFriendsPageFAEUpsell and var1.upsellEntrySurface == UpsellEntrySurfaceType.AddFriendsPage then
            return var4.ChatWithFriends, var4.GetASecureAgeCheckToUnlockChatAndAddTrustedFriends
        elseif var1.upsellEntrySurface == UpsellEntrySurfaceType.TrustedFriends
            or var1.upsellEntrySurface == UpsellEntrySurfaceType.TrustedFriendsInExperience
        then
            return var4.LetsCheckYourAge, var4.ToAddTrustedFriendDoAgeCheck
        end

        return var4.LetsCheckYourAgeSoYouCanUseChat, var4.ModalBodyInAppV3
    end

    local isPhase2 = if FFlagEnableAEGIS2CommsFAEUpsell then var1.isPhase2 else nil
    local upsellEntrySurface = var1.upsellEntrySurface
    local upsellEntryComponent = if FFlagAddFriendsPageFAEUpsell then var1.upsellEntryComponent else nil
    local title, bodyText = useMemo(func1, { isPhase2, upsellEntrySurface, var4, upsellEntryComponent })

    local onActivated = React.useCallback(function()
        var3.closeSocialOverlay()

        if var1.onAccept then
            var1.onAccept()
        end

        if game.JobId ~= "" and not FFlagEnableAEGIS2CommsFAEUpsell then
            return
        end

        var2(
            startFacialAgeEstimation(
                if var1.shouldIncludeVPC then var1.entryPointEventCtx or SocialUpsellType.FacialAgeEstimation .. (var1.upsellEntrySurface or "") else var1.entryPointEventCtx,
                var1.onSuccess,
                var1.onFailure,
                var1.upsellEntrySurface,
                if FFlagEnableAEGIS2CommsFAEUpsell then var1.isInExperience else nil,
                var1.shouldIncludeVPC
            )
        )
    end, {
        var2,
        var3.closeSocialOverlay,
        var1.upsellEntrySurface,
        var1.entryPointEventCtx,
        var1.onAccept,
        var1.onSuccess,
        var1.onFailure,
        var1.isInExperience,
        var1.shouldIncludeVPC
    })

    local onClose = React.useCallback(function()
        if var1.onDismiss then
            var1.onDismiss()
        end
    end, { var1.onDismiss })

    local countDownBadge = React.useMemo(function(): {deadlineUtcTimestamp: any, text: any}?
        return if FFlagEnableCountdownBadge and var1.countDownBadgeText then {
            text = var1.countDownBadgeText,
            deadlineUtcTimestamp = FIntCommsFAELockTimestamp
        } else nil
    end, { var1.countDownBadgeText })

    local useMemo2 = React.useMemo
    local function func2()
        return {
            text = if FFlagAddFriendsPageFAEUpsell and var1.upsellEntrySurface == UpsellEntrySurfaceType.AddFriendsPage then var4.Unlock elseif FFlagEnableAEGIS2CommsFAEUpsell and (bool2 or var1.isPhase2) and not var1.isInExperience then var4.UnlockChat else var4.Continue,
            onActivated = onActivated
        }
    end

    local isPhase2_2 = if FFlagEnableAEGIS2CommsFAEUpsell then var1.isPhase2 else nil
    local isInExperience = var1.isInExperience
    local upsellEntrySurface2 = if FFlagAddFriendsPageFAEUpsell then var1.upsellEntrySurface else nil
    local primaryAction = useMemo2(func2, { isPhase2_2, isInExperience, var4, onActivated, upsellEntrySurface2 })

    React.useEffect(function()
        if not var5.current and var1.onMounted then
            var1.onMounted()
        end

        var5.current = true
    end, { var1.onMounted })

    local createElement = React.createElement
    local var12 = UpsellOverlay
    local var13 = createCommonOverlayProps
    local tbl1 = {
        onClose = onClose,
        countDownBadge = countDownBadge,
        bodyText = bodyText,
        title = title,
        imageId = 0,
        primaryAction = 0,
        impressionId = 0,
        upsellEntryComponent = 0,
        upsellEntrySurface = 0,
        upsellPurpose = 0,
        containerRef = 0
    }
    local var14

    if FFlagAddFriendsPageFAEUpsell and var1.upsellEntrySurface == UpsellEntrySurfaceType.AddFriendsPage then
        var14 = assetId2
        tbl1.imageId = var14

        tbl1.primaryAction = primaryAction
        tbl1.impressionId = var1.impressionId
        tbl1.upsellEntryComponent = var1.upsellEntryComponent
        tbl1.upsellEntrySurface = var1.upsellEntrySurface
        tbl1.upsellPurpose = SocialUpsellType.FacialAgeEstimation
        tbl1.containerRef = var1.containerRef
        return createElement(var12, var13(tbl1, var1))
    end

    if FFlagEnableAEGIS2CommsFAEUpsell and (bool2 or var1.isPhase2) and not bool1 and var1.isInExperience then
        var14 = nil
    else
        var14 = assetId
    end

    tbl1.imageId = var14

    tbl1.primaryAction = primaryAction
    tbl1.impressionId = var1.impressionId
    tbl1.upsellEntryComponent = var1.upsellEntryComponent
    tbl1.upsellEntrySurface = var1.upsellEntrySurface
    tbl1.upsellPurpose = SocialUpsellType.FacialAgeEstimation
    tbl1.containerRef = var1.containerRef
    return createElement(var12, var13(tbl1, var1))
end
