-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:50:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local Signals = require(InExperienceShopParent.Signals)
local NotificationsOrchestrator = require(InExperienceShopParent.NotificationsOrchestrator)

local MarketplaceUnifiedItemType = require(InExperienceShopParent.AvatarExperienceAnalytics).UnifiedEventLogEnums.MarketplaceUnifiedItemType
local InExperienceOffers = require(InExperienceShopParent.InExperienceOffers)

local getInExperienceShopStore = require(InExperienceShop.Stores.getInExperienceShopStore)
local GetShopGlobalIconStore = require(InExperienceShop.Stores.GetShopGlobalIconStore)
local FFlagEnableExperienceShopGlobalIcon = require(InExperienceShop.Flags.FFlagEnableExperienceShopGlobalIcon)
local hasRedeemedTrialWithinWindow = require(InExperienceShop.Utils.hasRedeemedTrialWithinWindow)

local _Types = require(InExperienceShop.Types)

local maxImpressions = game:DefineFastInt("MaxTrialAvailableTooltipImpressions", 5)

local lifecycleKey = game:DefineFastString("TrialAvailableTooltipLifecycleKey", "trial-available-tooltip")
local cooldownSeconds = game:DefineFastInt("TrialAvailableTooltipCooldownSeconds", 86400)
local num1 = game:DefineFastInt("TrialAvailableTooltipDelayMs", 500)
local num2 = game:DefineFastInt("TrialAvailableTooltipDurationMs", 7000)

local FFlagEnableRedeemedFreeTrialTooltip = require(InExperienceShop.Flags.FFlagEnableRedeemedFreeTrialTooltip)
local FFlagEnableActiveFreeTrialTooltip = require(InExperienceShop.Flags.FFlagEnableActiveFreeTrialTooltip)
local bool1 = game:DefineFastFlag("TrialNotificationTooltipOnStudio", false)
local num3 = game:DefineFastInt("MaxRecentlyRedeemedTooltipImpressions", 5)

local tbl1 = {
    lifecycleKey = lifecycleKey,
    maxImpressions = maxImpressions,
    cooldownSeconds = cooldownSeconds,
    delayMs = num1,
    durationMs = num2,
    titleKey = "Feature.InExperienceShop.Label.HaveTrial",
    actionTextKey = "Feature.InExperienceShop.Label.TryNow",
    source = "GamePassTrialAvailableTooltip",
    action = "openShop"
}
local tbl2 = {
    lifecycleKey = game:DefineFastString("TrialRecentlyRedeemedTooltipLifecycleKey", "trial-recently-redeemed-tooltip"),
    maxImpressions = num3,
    cooldownSeconds = game:DefineFastInt("RecentlyRedeemedTooltipCooldownSeconds", 86400),
    delayMs = game:DefineFastInt("TrialRecentlyRedeemedTooltipDelayMs", 500),
    durationMs = game:DefineFastInt("TrialRecentlyRedeemedTooltipDurationMs", 7000),
    titleKey = "Feature.InExperienceShop.Tooltip.RecentlyRedeemed",
    actionTextKey = "Feature.InExperienceShop.Label.BuyGamePass",
    source = "GamePassTrialRecentlyRedeemedTooltip",
    action = "promptGamePassPurchase"
}

local function asTooltipSlot(str2: string): string -- Luacid: unused: defined but never referenced
    return str2
end

local effect = nil
local var1 = nil
local var2 = nil

local var3, var4 = Signals.createSignal(nil)

local var5 = nil
local var6 = nil

local delayMs = 0
local durationMs = 0
local str2 = "openShop"

local var7 = nil

local function hasAvailableTrial(trialAvailabilities): boolean -- Luacid: Inlined by compiler; 3 call sites recovered
    local _, var8 = next(trialAvailabilities.available)
    return var8 == true
end

local function hasActiveTrial(trialAvailabilities): boolean -- Luacid: Inlined by compiler; 5 call sites recovered
    local _, var8 = next(trialAvailabilities.active)
    return var8 == true
end

local function firstRedeemedGamePassId(trialAvailabilities)
    for value, value2 in trialAvailabilities.redeemed do
        if hasRedeemedTrialWithinWindow({ [value] = value2 }) then
            return value2.gamePassId
        end
    end
    return nil
end

local function firstActiveGamePassId(trialAvailabilities) -- Luacid: Inlined by compiler; 2 call sites recovered
    local var8, var9 = next(trialAvailabilities.active)
    return if var9 == true then var8 else nil
end

local function selectCampaign(trialAvailabilities) -- Luacid: Inlined by compiler; 2 call sites recovered
    if FFlagEnableActiveFreeTrialTooltip and hasActiveTrial(trialAvailabilities) then
        return tbl2
    end

    if FFlagEnableRedeemedFreeTrialTooltip and hasRedeemedTrialWithinWindow(trialAvailabilities.redeemed) then
        return tbl2
    end

    if hasAvailableTrial(trialAvailabilities) then
        return tbl1
    end

    return nil
end

local function chooseSlot(arg1)
    local var8 = InExperienceOffers.getOffersStore(false).getIsShopAvailable(arg1)
    if not FFlagEnableExperienceShopGlobalIcon then
        return if var8 then "EducationTooltipOnHamburger" else nil
    end

    if GetShopGlobalIconStore(false).getEnabled(arg1) then
        return "EducationTooltipOnShopIcon"
    end

    local inExperienceShopStore = getInExperienceShopStore(false)
    return if inExperienceShopStore.getLoading(arg1) or inExperienceShopStore.getGlobalIconBackendEnabled(arg1) then nil elseif var8 then "EducationTooltipOnHamburger" else nil
end

local function submitTooltip(slotId: string, tbl3, itemId: string?)
    local slotDisplayPayload = slotId == "EducationTooltipOnShopIcon"
        and {
            slot = "EducationTooltipOnShopIcon",
            title = tbl3.titleKey,
            actionText = tbl3.actionTextKey
        }
        or {
            slot = "EducationTooltipOnHamburger",
            title = tbl3.titleKey,
            actionText = tbl3.actionTextKey
        }
    local tbl5 = {
        slotId = slotId,
        priority = 0,
        lifecycleKey = tbl3.lifecycleKey,
        lifecyclePolicy = {
            frequency = {
                maxImpressions = tbl3.maxImpressions,
                window = "forever",
                cooldownSeconds = tbl3.cooldownSeconds
            },
            visibility = {
                delayMs = tbl3.delayMs,
                autoDismissAfterMs = tbl3.durationMs
            }
        },
        source = tbl3.source,
        slotDisplayPayload = slotDisplayPayload,
        itemId = itemId,
        itemType = if itemId == nil then nil else MarketplaceUnifiedItemType.GAME_PASS
    }
    if bool1 then
        tbl5.enableOnStudio = true
    end

    tbl5.suppressWhileInExperienceShopOpen = true
    return NotificationsOrchestrator.submit(tbl5)
end

local function readActiveTooltip(slot: string, arg1)
    local var8 = NotificationsOrchestrator.getActiveForSlot(slot)(arg1)

    local var9 = var3(arg1)
    if var8 == nil or var8.handle ~= var9 or var8.payload.slot ~= slot then
        return nil
    end
    local payload = var8.payload
    return {
        slot = slot,
        title = payload.title or "",
        actionText = payload.actionText or "",
        delayMs = delayMs,
        durationMs = durationMs,
        action = str2,
        gamePassId = var7
    }
end

local function activeHandle() -- Luacid: Inlined by compiler; 1 call site recovered
    local var8 = var2
    if var8 == nil or readActiveTooltip(var8, false) == nil then
        return nil
    end
    return var3(false)
end

local function isTrialTooltipShowing(arg1): boolean
    local var8 = var2
    if var8 ~= nil then
        return readActiveTooltip(var8, arg1) ~= nil
    end

    var3(arg1)
    return false
end

local function getActiveTooltip(arg1)
    local var8 = var2
    if var8 ~= nil then
        return (readActiveTooltip(var8, arg1))
    end

    var3(arg1)
    return nil
end

local function isShowingOnSlot(slot: string, arg1): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    local bool2 = readActiveTooltip(slot, arg1) ~= nil
    if var2 ~= slot then
        bool2 = false
    end

    return bool2
end

local function isHamburgerTooltipShowing(arg1): boolean
    return (isShowingOnSlot("EducationTooltipOnHamburger", arg1))
end

local function isShopIconTooltipShowing(arg1): boolean
    return (isShowingOnSlot("EducationTooltipOnShopIcon", arg1))
end

local function report(arg1)
    local var8 = var2
    local var9 = activeHandle()

    if var8 == nil or var9 == nil then
        return
    end
    if arg1.type == "mounted" then
        if var5 == var9 then
            return
        end
        var5 = var9
    elseif arg1.type == "viewed" then
        if var6 == var9 then
            return
        end
        var6 = var9
    end
    NotificationsOrchestrator.report(var8, var9, arg1)
end

local bool2 = false

local function submitFreeTrialTooltips() -- Luacid: Inlined by compiler; 1 call site recovered
    local var8 = var1
    if var8 ~= nil then
        return var8
    end

    local bool3 = false
    local inExperienceShopStore = getInExperienceShopStore(false)
    effect = Signals.createEffect(function(arg1)
        local trialAvailabilities = inExperienceShopStore.getTrialAvailabilities(arg1)
        local var9 = selectCampaign(trialAvailabilities)

        if bool2 or bool3 or var9 == nil then
            return
        end
        local slotId = chooseSlot(arg1)
        if slotId == nil then
            return
        end
        bool3 = true

        var2 = slotId

        delayMs = var9.delayMs
        durationMs = var9.durationMs
        str2 = var9.action
        var7 = if var9.action ~= "promptGamePassPurchase" then nil elseif FFlagEnableActiveFreeTrialTooltip and hasActiveTrial(trialAvailabilities) then firstActiveGamePassId(trialAvailabilities) else firstRedeemedGamePassId(trialAvailabilities)

        var4(submitTooltip(slotId, var9, var7))
    end)

    var1 = isTrialTooltipShowing
    return isTrialTooltipShowing
end

return (setmetatable({
    reportMounted = function()
        report({ type = "mounted" })
    end,
    reportViewed = function()
        report({ type = "viewed" })
    end,
    reportActivated = function()
        report({ type = "activated" })
    end,
    dismiss = function(arg1)
        bool2 = true
        report({ type = "dismissed", reason = if arg1 == nil then "activated" else arg1 })
    end,
    getActiveTooltip = getActiveTooltip,
    isHamburgerTooltipShowing = isHamburgerTooltipShowing,
    isShopIconTooltipShowing = isShopIconTooltipShowing
}, {
    __call = function(_)
        return submitFreeTrialTooltips()
    end
}))
