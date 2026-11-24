-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:41:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local StarterGui = game:GetService("StarterGui")

local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local Signals = require(InExperienceShopParent.Signals)
local SharedFlags = require(InExperienceShopParent.SharedFlags)
local InExperienceOffers = require(InExperienceShopParent.InExperienceOffers)
local FFlagEnableExperienceShopGlobalIcon = require(InExperienceShop.Flags.FFlagEnableExperienceShopGlobalIcon)
local FFlagExperienceShopGlobalIconSkipCoreGuiCheck = require(InExperienceShop.Flags.FFlagExperienceShopGlobalIconSkipCoreGuiCheck)
local FFlagOfferNotifyOnGlobalIcon = SharedFlags.FFlagOfferNotifyOnGlobalIcon
local FFlagEnableFreeTrialBlueDot = require(InExperienceShop.Flags.FFlagEnableFreeTrialBlueDot)
local getInExperienceShopStore = require(InExperienceShop.Stores.getInExperienceShopStore)
local GetShopGlobalIconStore = require(InExperienceShop.Stores.GetShopGlobalIconStore)

local function initShopGlobalIcon()
    if not FFlagEnableExperienceShopGlobalIcon then
        return nil
    end

    local shopGlobalIconStore = GetShopGlobalIconStore(false)
    local bool1

    if FFlagExperienceShopGlobalIconSkipCoreGuiCheck then
        bool1 = true
    else
        bool1 = StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.All)
        bool1 = bool1 or StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.ExperienceShop)
    end
    local bool2 = false

    local function updateEnabled() -- Luacid: Inlined by compiler; 2 call sites recovered
        local bool3 = bool1 and bool2
        shopGlobalIconStore.setEnabled(bool3)
        if FFlagOfferNotifyOnGlobalIcon then
            InExperienceOffers.getOffersStore(false).setInExperienceShopGlobalIconAvailable(bool3)
        end
    end

    local connection = if FFlagExperienceShopGlobalIconSkipCoreGuiCheck then nil else StarterGui.CoreGuiChangedSignal:Connect(function(coreGuiType: Enum.CoreGuiType, enabled: boolean)
        if coreGuiType == Enum.CoreGuiType.ExperienceShop or coreGuiType == Enum.CoreGuiType.All then
            bool1 = enabled
            updateEnabled()
        end
    end)

    local effect = nil
    effect = Signals.createEffect(function(arg1)
        local inExperienceShopStore = getInExperienceShopStore(false)
        if inExperienceShopStore.getLoading(arg1) or not inExperienceShopStore.getGlobalIconBackendEnabled(arg1) then
            return
        end

        bool2 = true
        updateEnabled()

        if not FFlagOfferNotifyOnGlobalIcon then
            shopGlobalIconStore.setStatusIndicatorEnabled(inExperienceShopStore.getGlobalIconHasNewOffers(arg1))
        end
        task.defer(function()
            if effect then
                effect()
                effect = nil
            end
        end)
    end)

    local effect2 = if FFlagOfferNotifyOnGlobalIcon then Signals.createEffect(function(arg1)
        local var1 = InExperienceOffers.getOffersStore(arg1).getOfferNotificationShownWithEnum(arg1)
        shopGlobalIconStore.setStatusIndicatorEnabled(var1 == InExperienceOffers.NotificationLocation.GlobalIcon)
    end) else nil

    local effect3 = nil
    if FFlagEnableFreeTrialBlueDot then
        local submitFreeTrialBlueDot = require(InExperienceShop.submitFreeTrialBlueDot)
        effect3 = Signals.createEffect(function(arg1)
            local var1 = submitFreeTrialBlueDot.isShopIconBlueDotShowing(arg1)
            shopGlobalIconStore.setFreeTrialStatusIndicatorEnabled(var1)
            if var1 then
                submitFreeTrialBlueDot.reportMounted()
                submitFreeTrialBlueDot.reportViewed()
            end
        end)
    end

    return function()
        if not FFlagExperienceShopGlobalIconSkipCoreGuiCheck and connection then
            connection:Disconnect()
        end
        if effect then
            effect()
            effect = nil
        end
        if effect2 then
            effect2()
            effect2 = nil
        end
        if effect3 then
            effect3()
            effect3 = nil
            shopGlobalIconStore.setFreeTrialStatusIndicatorEnabled(false)
        end

        if FFlagOfferNotifyOnGlobalIcon then
            InExperienceOffers.getOffersStore(false).setInExperienceShopGlobalIconAvailable(false)
        end
    end
end

return initShopGlobalIcon
