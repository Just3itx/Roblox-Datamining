-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T21:00:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GamePlayButton = script:FindFirstAncestor("GamePlayButton")
local GamePlayButtonParent = GamePlayButton.Parent
local PlayButtonStates = require(GamePlayButton.PlayButtonStates)
local _PlayabilityRodux = require(GamePlayButtonParent.PlayabilityRodux)
local PlayabilityStatusEnum = require(GamePlayButtonParent.DiscoveryTypes).PlayabilityStatusEnum
local getAppFeaturePolicies = require(GamePlayButtonParent.UniversalAppPolicy).getAppFeaturePolicies
local LaunchErrorLocalizationKeys = require(GamePlayButtonParent.GameLaunch).LaunchErrorLocalizationKeys
local useSelector = require(GamePlayButtonParent.RoactUtils).Hooks.RoactRodux.useSelector
local GameHydrationReact = require(GamePlayButtonParent.GameHydrationReact)
local FFlagEnableGameJoinEarlyAccess = require(GamePlayButtonParent.SharedFlags).FFlagEnableGameJoinEarlyAccess
local useGameProductInfoSelector = require(GamePlayButtonParent.GameProductInfoRodux).useGameProductInfoSelector
local useAppPolicy = require(GamePlayButtonParent.UniversalAppPolicy).useAppPolicy
local useLocalization = require(GamePlayButtonParent.Localization).Hooks.useLocalization
local ExperienceDetailsNoticeType = require(GamePlayButtonParent.DiscoveryTypes).ExperienceDetailsNoticeType

local function func1(arg1, arg2, arg3)
    if not arg2 then
        return nil
    end

    if arg1 == nil
        or (arg2.playabilityStatus == PlayabilityStatusEnum.PurchaseRequired
            or arg2.playabilityStatus == PlayabilityStatusEnum.FiatPurchaseRequired)
            and (arg3 == nil or arg3.isForSale == false)
    then
        return "Feature.ExperienceDetails.UnplayableError.UnplayableOther"
    end
    if arg2.playabilityStatus == PlayabilityStatusEnum.DeviceRestricted then
        local device = getAppFeaturePolicies().getPlatformDisplayName() or ""
        if device ~= "" then
            return "Feature.ExperienceDetails.UnplayableError.DeviceRestrictedCustom", {
                device = device
            }
        end
    end
    return LaunchErrorLocalizationKeys[arg2.playabilityStatus]
end

local function func2(arg1, arg2, arg3) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1, var2 = func1(arg1, arg2, arg3)
    if var1 == nil then
        return nil
    end

    if not var2 then
        return var1
    end

    local var3 = table.clone(var2)
    var3[1] = var1
    return var3
end

return function(arg1, str1: string, arg2)
    local var1 = useAppPolicy(function(arg3)
        return {
            experienceDetailsNoticeType = arg3.getExperienceDetailsNoticeType()
        }
    end)

    local var2 = useSelector(function(arg3)
        return arg3.PlayabilityStatus and arg3.PlayabilityStatus[arg1] and arg3.PlayabilityStatus[arg1].unplayableDisplayText or nil
    end)

    local var3 = useSelector(function(arg3)
        return arg3.GameDetails[arg1]
    end)
    local var4 = GameHydrationReact.useGameInfo(arg1)
    local rootPlaceId = var3 and var3.rootPlaceId

    if not rootPlaceId then
        if var4 then
            rootPlaceId = var4.rootPlaceId or nil
        else
            rootPlaceId = nil
        end
    end

    local var5 = useGameProductInfoSelector(arg1)
    local var6 = useLocalization({
        agreeToNotice = "Feature.ExperienceDetails.PlayButtonMessage.AgreeToNotice",
        unplayableOtherFallback = if str1 == PlayButtonStates.UnplayableOther then func2(rootPlaceId, arg2, var5) else nil
    })

    if (str1 == PlayButtonStates.Playable
        or str1 == PlayButtonStates.PlayableWithParty
        or str1 == PlayButtonStates.WaitingForParty)
        and var1.experienceDetailsNoticeType == ExperienceDetailsNoticeType.InExperiencePurchase
    then
        return var6.agreeToNotice
    end

    if FFlagEnableGameJoinEarlyAccess
        and arg2 ~= nil
        and arg2.playabilityStatus == PlayabilityStatusEnum.PlusSubscriptionRequired
    then
        return nil
    end

    if var2 and var2 ~= "" then
        return var2
    end

    if str1 == PlayButtonStates.UnplayableOther then
        return var6.unplayableOtherFallback
    end

    return nil
end
