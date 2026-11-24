-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:50:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local Signals = require(InExperienceShopParent.Signals)
local NotificationsOrchestrator = require(InExperienceShopParent.NotificationsOrchestrator)
local InExperienceOffers = require(InExperienceShopParent.InExperienceOffers)

local getInExperienceShopStore = require(InExperienceShop.Stores.getInExperienceShopStore)
local GetShopGlobalIconStore = require(InExperienceShop.Stores.GetShopGlobalIconStore)
local FIntMaxTrialBlueDotImpressions = require(InExperienceShop.Flags.FIntMaxTrialBlueDotImpressions)
local FIntMaxRedeemedTrialBlueDotImpressions = require(InExperienceShop.Flags.FIntMaxRedeemedTrialBlueDotImpressions)
local FStringAvailableTrialBlueDotLifecycleKey = require(InExperienceShop.Flags.FStringAvailableTrialBlueDotLifecycleKey)
local FStringRedeemedTrialBlueDotLifecycleKey = require(InExperienceShop.Flags.FStringRedeemedTrialBlueDotLifecycleKey)
local FIntTrialBlueDotCooldownSeconds = require(InExperienceShop.Flags.FIntTrialBlueDotCooldownSeconds)
local FIntRedeemedTrialBlueDotCooldownSeconds = require(InExperienceShop.Flags.FIntRedeemedTrialBlueDotCooldownSeconds)
local FFlagEnableExperienceShopGlobalIcon = require(InExperienceShop.Flags.FFlagEnableExperienceShopGlobalIcon)
local FFlagTrialNotificationBlueDotOnStudio = require(InExperienceShop.Flags.FFlagTrialNotificationBlueDotOnStudio)
local FFlagEnableActiveFreeTrialBlueDot = require(InExperienceShop.Flags.FFlagEnableActiveFreeTrialBlueDot)
local FFlagEnableRedeemedFreeTrialBlueDot = require(InExperienceShop.Flags.FFlagEnableRedeemedFreeTrialBlueDot)
local hasRedeemedTrialWithinWindow = require(InExperienceShop.Utils.hasRedeemedTrialWithinWindow)

local _Types = require(InExperienceShop.Types)

local tbl1 = {
    lifecycleKey = FStringRedeemedTrialBlueDotLifecycleKey,
    maxImpressions = FIntMaxRedeemedTrialBlueDotImpressions,
    cooldownSeconds = FIntRedeemedTrialBlueDotCooldownSeconds
}

local tbl2 = {
    available = {
        lifecycleKey = FStringAvailableTrialBlueDotLifecycleKey,
        maxImpressions = FIntMaxTrialBlueDotImpressions,
        cooldownSeconds = FIntTrialBlueDotCooldownSeconds
    },
    active = tbl1,
    redeemed = tbl1
}

local function asBlueDotSlot(str1: string): string -- Luacid: unused: defined but never referenced
    return str1
end

local function asTrialKind(str1: string): string -- Luacid: unused: defined but never referenced
    return str1
end

local effect = nil
local var1 = nil
local var2, var3 = Signals.createSignal(nil)

local var4 = nil
local var5 = nil

local function trialKind(trialAvailabilities) -- Luacid: Inlined by compiler; 2 call sites recovered
    if FFlagEnableActiveFreeTrialBlueDot and next(trialAvailabilities.active) ~= nil then
        return "active"
    end

    if FFlagEnableRedeemedFreeTrialBlueDot and hasRedeemedTrialWithinWindow(trialAvailabilities.redeemed) then
        return "redeemed"
    end

    if next(trialAvailabilities.available) == nil then
        return nil
    end

    return "available"
end

local function chooseSlot(arg1)
    local var6 = InExperienceOffers.getOffersStore(false).getIsShopAvailable(arg1)
    if not FFlagEnableExperienceShopGlobalIcon then
        return if var6 then "HamburgerBlueDot" else nil
    end

    if GetShopGlobalIconStore(false).getEnabled(arg1) then
        return "ShopIconBlueDot"
    end

    local inExperienceShopStore = getInExperienceShopStore(false)
    return if inExperienceShopStore.getLoading(arg1) or inExperienceShopStore.getGlobalIconBackendEnabled(arg1) then nil elseif var6 then "HamburgerBlueDot" else nil
end

local function submitBlueDot(slotId: string, str1: string)
    local lifecycle = NotificationsOrchestrator.getSlotConfig(slotId).lifecycle
    local visibility = if lifecycle == nil then nil else lifecycle.visibility
    local var6 = tbl2[str1]
    return NotificationsOrchestrator.submit({
        slotId = slotId,
        priority = 0,
        lifecycleKey = var6.lifecycleKey,
        lifecyclePolicy = {
            frequency = {
                maxImpressions = var6.maxImpressions,
                window = "forever",
                cooldownSeconds = var6.cooldownSeconds
            },
            visibility = visibility
        },
        source = "GamePassFreeTrialBlueDot",
        slotDisplayPayload = slotId == "ShopIconBlueDot" and { slot = "ShopIconBlueDot" } or {
            slot = "HamburgerBlueDot"
        },
        enableOnStudio = FFlagTrialNotificationBlueDotOnStudio
    })
end

local function isActiveNotification(str1: string, arg1): boolean -- Luacid: Inlined by compiler; 6 call sites recovered
    local var6 = var2(arg1)
    local var7 = NotificationsOrchestrator.getActiveForSlot(str1)(arg1)

    return not (var6 == nil or var6.slotId ~= str1 or var7 == nil or var7.payload.slot ~= str1) and var7.handle == var6.handle
end

local function activeHandle() -- Luacid: unused: defined but never referenced
    local var6 = var2(false)
    return if var6 == nil or not isActiveNotification(var6.slotId, false) then nil else var6.handle
end

local function isTrialBlueDotShowing(arg1)
    local var6 = var2(arg1)
    if var6 == nil then
        return false
    end

    return (isActiveNotification(var6.slotId, arg1))
end

local function isShowingOnSlot(str1: string, arg1): boolean -- Luacid: Inlined by compiler; 3 call sites recovered
    return (isActiveNotification(str1, arg1))
end

local function report(arg1)
    local var6 = var2(false)
    local var7 = var2(false)
    local handle = if var7 == nil or not isShowingOnSlot(var7.slotId, false) then nil else var7.handle

    if var6 == nil or handle == nil then
        return
    end
    if arg1.type == "mounted" then
        if var4 == handle then
            return
        end
        var4 = handle
    elseif arg1.type == "viewed" then
        if var5 == handle then
            return
        end
        var5 = handle
    end
    NotificationsOrchestrator.report(var6.slotId, handle, arg1)
end

local bool1 = false

local function submitFreeTrialBlueDot() -- Luacid: Inlined by compiler; 1 call site recovered
    local var6 = var1
    if var6 ~= nil then
        return var6
    end

    local bool2 = false
    local inExperienceShopStore = getInExperienceShopStore(false)
    effect = Signals.createEffect(function(arg1)
        local trialAvailabilities = inExperienceShopStore.getTrialAvailabilities(arg1)
        if bool1 or bool2 then
            return
        end

        local var7 = trialKind(trialAvailabilities)

        if var7 == nil then
            return
        end
        local slotId = chooseSlot(arg1)
        if slotId == nil then
            return
        end
        bool2 = true

        var3({ slotId = slotId, handle = submitBlueDot(slotId, var7) })
    end)

    var1 = isTrialBlueDotShowing
    return isTrialBlueDotShowing
end

return (setmetatable({
    reportMounted = function()
        report({ type = "mounted" })
    end,
    reportViewed = function()
        report({ type = "viewed" })
    end,
    reportActivated = function()
        if not NotificationsOrchestrator.Flags.FFlagEnableNotificationsOrchestratorUnifiedLogging then
            return
        end
        report({ type = "activated" })
    end,
    dismiss = function()
        bool1 = true
        report({ type = "dismissed", reason = "activated" })
    end,
    isHamburgerBlueDotShowing = function(arg1): boolean
        return isShowingOnSlot("HamburgerBlueDot", arg1)
    end,
    isShopIconBlueDotShowing = function(arg1): boolean
        return isShowingOnSlot("ShopIconBlueDot", arg1)
    end
}, {
    __call = function(_)
        return submitFreeTrialBlueDot()
    end
}))
