-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:50:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocalizationService = game:GetService("LocalizationService")

local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local Signals = require(InExperienceShopParent.Signals)
local Localization = require(InExperienceShopParent.AppLocales).Localization
local NotificationsOrchestrator = require(InExperienceShopParent.NotificationsOrchestrator)

local getInExperienceShopStore = require(InExperienceShop.Stores.getInExperienceShopStore)
local FIntMaxTrialBadgeImpressions = require(InExperienceShop.Flags.FIntMaxTrialBadgeImpressions)
local FStringTrialBadgeLifecycleKey = require(InExperienceShop.Flags.FStringTrialBadgeLifecycleKey)
local FIntTrialBadgeCooldownSeconds = require(InExperienceShop.Flags.FIntTrialBadgeCooldownSeconds)
local FFlagTrialNotificationBadgeOnStudio = require(InExperienceShop.Flags.FFlagTrialNotificationBadgeOnStudio)
local FFlagEnableActiveFreeTrialShopMenuBadge = require(InExperienceShop.Flags.FFlagEnableActiveFreeTrialShopMenuBadge)
local FFlagEnableRedeemedFreeTrialShopMenuBadge = require(InExperienceShop.Flags.FFlagEnableRedeemedFreeTrialShopMenuBadge)

local _Types = require(InExperienceShop.Types)

local effect = nil
local var1 = nil

local var2, var3 = Signals.createSignal(nil)

local function hasTrialToBadge(trialAvailabilities): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return not (next(trialAvailabilities.available) == nil)
        or (if FFlagEnableActiveFreeTrialShopMenuBadge and next(trialAvailabilities.active) ~= nil then true else not not (FFlagEnableRedeemedFreeTrialShopMenuBadge and next(trialAvailabilities.redeemed) ~= nil))
end

local function freeTrialLabel() -- Luacid: Inlined by compiler; 2 call sites recovered
    return Localization.new(LocalizationService.RobloxLocaleId):Format("Feature.InExperienceShop.Label.FreeTrial")
end

local function shopMenuBadgeText(arg1)
    local var4 = NotificationsOrchestrator.getActiveForSlot(NotificationsOrchestrator.SlotId.ShopMenuBadge)(arg1)

    local var5 = var2(arg1)
    return if var4 == nil or var4.payload.slot ~= "ShopMenuBadge" or var4.handle ~= var5 then nil else var4.payload.text
end

local function activeHandle() -- Luacid: Inlined by compiler; 5 call sites recovered
    local var4 = NotificationsOrchestrator.getActiveForSlot(NotificationsOrchestrator.SlotId.ShopMenuBadge)(false)
    return if var4 == nil or var4.payload.slot ~= "ShopMenuBadge" or var4.handle ~= var2(false) then nil else var4.handle
end

local function report(arg1) -- Luacid: Inlined by compiler; 4 call sites recovered
    local var4 = activeHandle()

    if var4 == nil then
        return
    end
    NotificationsOrchestrator.report(NotificationsOrchestrator.SlotId.ShopMenuBadge, var4, arg1)
end

local function submitFreeTrialMenuBadge() -- Luacid: Inlined by compiler; 1 call site recovered
    local var4 = var1
    if var4 ~= nil then
        return var4
    end

    local bool1 = false
    local inExperienceShopStore = getInExperienceShopStore(false)
    effect = Signals.createEffect(function(arg1)
        local trialAvailabilities = inExperienceShopStore.getTrialAvailabilities(arg1)

        if bool1 or not hasTrialToBadge(trialAvailabilities) then
            return
        end

        local text = freeTrialLabel()

        bool1 = true
        var3(
            NotificationsOrchestrator.submit({
                slotId = NotificationsOrchestrator.SlotId.ShopMenuBadge,
                priority = 0,
                enableOnStudio = FFlagTrialNotificationBadgeOnStudio,
                lifecycleKey = FStringTrialBadgeLifecycleKey,
                lifecyclePolicy = {
                    frequency = {
                        maxImpressions = FIntMaxTrialBadgeImpressions,
                        window = "forever",
                        cooldownSeconds = FIntTrialBadgeCooldownSeconds
                    }
                },
                source = "GamePassFreeTrial",
                slotDisplayPayload = { slot = "ShopMenuBadge", text = text }
            })
        )
    end)

    var1 = shopMenuBadgeText
    return shopMenuBadgeText
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
        report({ type = "dismissed", reason = "activated" })
    end
}, {
    __call = function(_)
        return submitFreeTrialMenuBadge()
    end
}))
