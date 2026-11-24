-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:51:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local Signals = require(InExperienceShopParent.Signals)
local NotificationsOrchestrator = require(InExperienceShopParent.NotificationsOrchestrator)

local MarketplaceUnifiedItemType = require(InExperienceShopParent.AvatarExperienceAnalytics).UnifiedEventLogEnums.MarketplaceUnifiedItemType

local getInExperienceShopStore = require(InExperienceShop.Stores.getInExperienceShopStore)
local FFlagFreeTrialChipBuyAnimation = require(InExperienceShop.Flags.FFlagFreeTrialChipBuyAnimation)
local FFlagTrialNotificationTopBarChipOnStudio = require(InExperienceShop.Flags.FFlagTrialNotificationTopBarChipOnStudio)
local FIntFreeTrialUpsellTimerSecs = require(InExperienceShop.Flags.FIntFreeTrialUpsellTimerSecs)
local FIntFreeTrialUpsellAutoDismissAfterSecs = require(InExperienceShop.Flags.FIntFreeTrialUpsellAutoDismissAfterSecs)

local FreeTrialTopBarChip = NotificationsOrchestrator.SlotId.FreeTrialTopBarChip

local var1 = nil
local bool1 = false
local var2 = nil
local var3 = nil
local handle, var5 = Signals.createSignal(nil)
local var6, var7 = Signals.createSignal("active")
local func1, func2, func3, func4

if FFlagFreeTrialChipBuyAnimation then
    func1, func2 = Signals.createSignal(false)
    func3, func4 = Signals.createSignal(nil)
else
    func1 = function(_): boolean
        return false
    end
    func2 = function(_) end
    func3 = function(_)
        return nil
    end
    func4 = function(_) end
end
local var8 = nil
local var9 = nil
local num1 = 0

local var10 = nil
local gamePassId = nil
local gamePassId2 = nil

local function cancelUpsellTimer() -- Luacid: Inlined by compiler; 3 call sites recovered
    local var11 = var8
    if var11 ~= nil then
        task.cancel(var11)
        var8 = nil
    end
end

local function cancelBuyDismissTimer() -- Luacid: Inlined by compiler; 6 call sites recovered
    local var11 = var9
    if var11 ~= nil then
        task.cancel(var11)
        var9 = nil
    end
end

local function isChipShowing(arg1): boolean -- Luacid: Inlined by compiler; 15 call sites recovered
    local var11 = handle(arg1)
    if var11 == nil then
        return false
    end
    local var12 = NotificationsOrchestrator.getActiveForSlot(FreeTrialTopBarChip)(arg1)
    return not (var12 == nil or var12.payload.slot ~= "FreeTrialTopBarChip") and var12.handle == var11
end

local function chipImage(arg1)
    if isChipShowing(arg1) then
        local var11 = NotificationsOrchestrator.getActiveForSlot(FreeTrialTopBarChip)(arg1)
        return if var11 == nil or var11.payload.slot ~= "FreeTrialTopBarChip" then nil else var11.payload.image
    elseif FFlagFreeTrialChipBuyAnimation and func1(arg1) then
        return func3(arg1)
    else
        return nil
    end
end

local function report(arg1)
    if not isChipShowing(false) then
        return
    end
    local var11 = handle(false)
    if var11 == nil then
        return
    end

    if arg1.type == "mounted" then
        if var2 == var11 then
            return
        end
        var2 = var11
    elseif arg1.type == "viewed" then
        if var3 == var11 then
            return
        end
        var3 = var11
    end
    NotificationsOrchestrator.report(FreeTrialTopBarChip, var11, arg1)
end

local function dismissActiveForPurchasedGamePass(str1: string, bool2: boolean)
    if not bool2 or gamePassId2 ~= str1 or var6(false) ~= "active" then
        return
    end

    if var10 ~= nil and var10 == num1 then
        var10 = nil
        num1 += 1
        if FFlagFreeTrialChipBuyAnimation then
            func2(false)
        end

        return
    end

    if not isChipShowing(false) then
        return
    end

    cancelUpsellTimer()

    if FFlagFreeTrialChipBuyAnimation then
        func2(false)
    end
    report({ type = "dismissed", reason = "other" })
end

local function buyAutoDismissAfterMs() -- Luacid: Inlined by compiler; 1 call site recovered
    return if FIntFreeTrialUpsellAutoDismissAfterSecs <= 0 then nil else FIntFreeTrialUpsellAutoDismissAfterSecs * 1000
end

local function scheduleBuyAutoDismiss(str1: string) -- Luacid: unused: defined but never referenced
    cancelBuyDismissTimer()
    local var11 = FIntFreeTrialUpsellAutoDismissAfterSecs
    if var11 <= 0 then
        return
    end
    var9 = task.delay(var11, function()
        var9 = nil

        if handle(false) == str1 and isChipShowing(false) then
            report({ type = "dismissed", reason = "timeout" })
        end
    end)
end

local function submitNotification(str1: string, tbl1)
    if not getInExperienceShopStore(false).getNotificationFreeTrialTopBarChip(false) then
        NotificationsOrchestrator.report(
            FreeTrialTopBarChip,
            if str1 == "upsell" then "free-trial-top-bar-upsell-chip" else "free-trial-top-bar-chip",
            { type = "suppressed" }
        )

        return nil
    end
    var7(str1)
    if str1 == "active" then
        gamePassId2 = tbl1.gamePassId
    end
    gamePassId = if str1 == "upsell" then tbl1.gamePassId else nil
    local autoDismissAfterMs = if str1 == "upsell" then buyAutoDismissAfterMs() else nil
    local var12 = NotificationsOrchestrator.submit({
        slotId = FreeTrialTopBarChip,
        priority = 0,
        enableOnStudio = FFlagTrialNotificationTopBarChipOnStudio,
        lifecycleKey = if str1 == "upsell" then "free-trial-top-bar-upsell-chip" else "free-trial-top-bar-chip",
        lifecyclePolicy = {
            frequency = {},
            visibility = autoDismissAfterMs ~= nil and { autoDismissAfterMs = autoDismissAfterMs } or nil
        },
        source = if str1 == "upsell" then "GamePassFreeTrialUpsellTopBarChip" else "GamePassFreeTrialActiveTopBarChip",
        itemId = tbl1.gamePassId,
        itemType = MarketplaceUnifiedItemType.GAME_PASS,
        slotDisplayPayload = {
            slot = "FreeTrialTopBarChip",
            image = if tbl1.image == "" then nil else tbl1.image
        }
    })
    var5(var12)
    return var12
end

local function submitUpsell(tbl1) -- Luacid: unused: defined but never referenced
    local var11 = submitNotification("upsell", tbl1)
    if var11 == nil then
        return
    end

    cancelBuyDismissTimer()
    local var12 = FIntFreeTrialUpsellAutoDismissAfterSecs
    if var12 <= 0 then
        return
    end
    var9 = task.delay(var12, function()
        var9 = nil

        if handle(false) == var11 and isChipShowing(false) then
            report({ type = "dismissed", reason = "timeout" })
        end
    end)
end

local function scheduleUpsellTimer(str1: string, tbl1) -- Luacid: unused: defined but never referenced
    cancelUpsellTimer()
    num1 += 1
    local num2 = num1
    var8 = task.delay(FIntFreeTrialUpsellTimerSecs, function()
        var8 = nil
        if num2 ~= num1 or handle(false) ~= str1 and isChipShowing(false) then
            return
        end

        if handle(false) == str1 and isChipShowing(false) then
            if FFlagFreeTrialChipBuyAnimation then
                func4(chipImage(false))
                func2(true)
            end
            report({ type = "dismissed", reason = "timeout" })
        end
        local inExperienceShopStore = getInExperienceShopStore(false)
        local function submitBuyUnlessReplaced(bool2: boolean)
            if num2 ~= num1 then
                return
            end
            var10 = nil
            if bool2 then
                if FFlagFreeTrialChipBuyAnimation then
                    func2(false)
                end
                return
            end

            local var11 = submitNotification("upsell", tbl1)

            if var11 ~= nil then
                cancelBuyDismissTimer()
                local var12 = FIntFreeTrialUpsellAutoDismissAfterSecs
                if not (var12 <= 0) then
                    var9 = task.delay(var12, function()
                        var9 = nil

                        if handle(false) == var11 and isChipShowing(false) then
                            report({ type = "dismissed", reason = "timeout" })
                        end
                    end)
                end
            end

            if FFlagFreeTrialChipBuyAnimation then
                func2(false)
            end
        end
        var10 = num2
        inExperienceShopStore.currentlyOwnsGamePass(tbl1.gamePassId):andThen(submitBuyUnlessReplaced):catch(function()
            if num2 ~= num1 then
                return
            end
            var10 = nil
            local var11 = submitNotification("upsell", tbl1)

            if var11 ~= nil then
                cancelBuyDismissTimer()
                local var12 = FIntFreeTrialUpsellAutoDismissAfterSecs
                if not (var12 <= 0) then
                    var9 = task.delay(var12, function()
                        var9 = nil

                        if handle(false) == var11 and isChipShowing(false) then
                            report({ type = "dismissed", reason = "timeout" })
                        end
                    end)
                end
            end

            if FFlagFreeTrialChipBuyAnimation then
                func2(false)
            end
        end)
    end)
end

local function start()
    if bool1 then
        return
    end
    bool1 = true

    local var11 = nil
    local inExperienceShopStore = getInExperienceShopStore(false)
    local effect = Signals.createEffect(function(arg1)
        local trialRedeemThumbnail = inExperienceShopStore.getTrialRedeemThumbnail(arg1)
        if trialRedeemThumbnail == nil or trialRedeemThumbnail == var11 then
            return
        end
        var11 = trialRedeemThumbnail

        if isChipShowing(false) then
            return
        end
        local tbl1 = {
            image = trialRedeemThumbnail.image,
            gamePassId = trialRedeemThumbnail.gamePassId
        }
        local var12 = submitNotification("active", tbl1)
        if var12 == nil or not (FIntFreeTrialUpsellTimerSecs > 0) then
            return
        end

        cancelUpsellTimer()
        num1 += 1
        local var13 = num1
        var8 = task.delay(FIntFreeTrialUpsellTimerSecs, function()
            var8 = nil
            if var13 ~= num1 or handle(false) ~= var12 and isChipShowing(false) then
                return
            end

            if handle(false) == var12 and isChipShowing(false) then
                if FFlagFreeTrialChipBuyAnimation then
                    func4(chipImage(false))
                    func2(true)
                end
                report({ type = "dismissed", reason = "timeout" })
            end
            local inExperienceShopStore2 = getInExperienceShopStore(false)
            local function submitBuyUnlessReplaced(bool2: boolean)
                if var13 ~= num1 then
                    return
                end
                var10 = nil
                if bool2 then
                    if FFlagFreeTrialChipBuyAnimation then
                        func2(false)
                    end
                    return
                end

                local var14 = submitNotification("upsell", tbl1)

                if var14 ~= nil then
                    cancelBuyDismissTimer()
                    local var15 = FIntFreeTrialUpsellAutoDismissAfterSecs
                    if not (var15 <= 0) then
                        var9 = task.delay(var15, function()
                            var9 = nil

                            if handle(false) == var14 and isChipShowing(false) then
                                report({ type = "dismissed", reason = "timeout" })
                            end
                        end)
                    end
                end

                if FFlagFreeTrialChipBuyAnimation then
                    func2(false)
                end
            end
            var10 = var13
            inExperienceShopStore2.currentlyOwnsGamePass(tbl1.gamePassId):andThen(submitBuyUnlessReplaced):catch(function()
                if var13 ~= num1 then
                    return
                end
                var10 = nil
                local var14 = submitNotification("upsell", tbl1)

                if var14 ~= nil then
                    cancelBuyDismissTimer()
                    local var15 = FIntFreeTrialUpsellAutoDismissAfterSecs
                    if not (var15 <= 0) then
                        var9 = task.delay(var15, function()
                            var9 = nil

                            if handle(false) == var14 and isChipShowing(false) then
                                report({ type = "dismissed", reason = "timeout" })
                            end
                        end)
                    end
                end

                if FFlagFreeTrialChipBuyAnimation then
                    func2(false)
                end
            end)
        end)
    end)
    local effect2 = Signals.createEffect(function(arg1)
        local purchasedOwnedGamePass = inExperienceShopStore.getPurchasedOwnedGamePass(arg1)
        if purchasedOwnedGamePass == nil then
            return
        end
        dismissActiveForPurchasedGamePass(purchasedOwnedGamePass.gamePassId, true)
    end)
    var1 = function()
        effect()
        effect2()
    end
end

return (setmetatable({
    isShowing = isChipShowing,
    isPresented = function(arg1)
        if isChipShowing(arg1) then
            return true
        end
        return func1(arg1 or false)
    end,
    handle = handle,
    image = chipImage,
    textKey = function(arg1): string
        return if var6(arg1) == "upsell" then "Feature.Catalog.Action.Buy" else "Feature.InExperienceShop.Label.Active"
    end,
    isEmphasis = function(arg1): boolean
        return var6(arg1) == "upsell"
    end,
    promptsPurchase = function(arg1): boolean
        return var6(arg1) == "upsell"
    end,
    promptPurchase = function()
        report({ type = "activated" })
        local var11 = gamePassId
        report({ type = "dismissed", reason = "activated" })
        if var11 == nil or var11 == "" then
            return
        end

        require(InExperienceShop.initiateShopItemPurchase)(var11, "GamePass")
    end,
    dismissActiveForPurchasedGamePass = dismissActiveForPurchasedGamePass,
    reportMounted = function()
        report({ type = "mounted" })
    end,
    reportViewed = function()
        report({ type = "viewed" })
    end,
    reportActivated = function()
        report({ type = "activated" })
    end,
    dismiss = function()
        if FFlagFreeTrialChipBuyAnimation then
            func2(false)
        end
        report({ type = "dismissed", reason = "user" })
    end
}, {
    __call = function(_)
        start()
        return isChipShowing
    end
}))
