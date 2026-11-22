-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:50:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxSubscriptionPurchaseApp = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp")
local RobloxSubscriptionPurchaseAppParent = RobloxSubscriptionPurchaseApp.Parent
local React = require(RobloxSubscriptionPurchaseAppParent.React)
local RobloxSubscriptionStore = require(RobloxSubscriptionPurchaseApp.Store.RobloxSubscriptionStore)
local PromptState = require(RobloxSubscriptionPurchaseApp.Enums.PromptState)
local completeRobloxSubscriptionUpsellFlow = require(RobloxSubscriptionPurchaseApp.Actions.completeRobloxSubscriptionUpsellFlow)

local FFlagEnableHeadlessSubscriptionNativePurchaseCancelCallback = require(RobloxSubscriptionPurchaseApp.Flags.FFlagEnableHeadlessSubscriptionNativePurchaseCancelCallback)

local FFlagLuaAppEnableNativePurchaseFinishedV2Signals = require(RobloxSubscriptionPurchaseAppParent.SharedFlags).FFlagLuaAppEnableNativePurchaseFinishedV2Signals

local function useNativePurchaseFinishedListenerLegacy<T>(func1: ((...any) -> (...any))?, func2: ((...any) -> (...any))?, func3: ((...any) -> (...any))?, func4: ((...any) -> (...any))?)
    local var1 = RobloxSubscriptionStore.get()
    local var2 = React.useRef(var1)

    local var3 = React.useMemo(function(): () -> RBXScriptSignal | (...any) -> (...any)
        return func1 or function(): RBXScriptSignal
            return game:GetService("MarketplaceService").NativePurchaseFinishedWithLocalPlayer
        end
    end, { func1 })

    local var4 = React.useMemo(function(): () -> RBXScriptSignal | (...any) -> (...any)
        return func2 or function(): RBXScriptSignal
            return game:GetService("MarketplaceService").NativePurchaseFinished
        end
    end, { func2 })

    React.useEffect(function()
        local connection = var3():Connect(function(_, arg1)
            local current = var2.current

            if current.getPromptState() ~= PromptState.SubscriptionPurchaseInProgress then
                return
            end

            if arg1 then
                current.setDidTryPurchasing(true)
                completeRobloxSubscriptionUpsellFlow()
                return
            end
            current.setPromptState(PromptState.SubscriptionPurchaseUIReady)
        end)

        local connection2 = var4():Connect(function(_, _, arg1)
            local current = var2.current

            if current.getPromptState() ~= PromptState.SubscriptionPurchaseInProgress then
                return
            end

            if arg1 then
                current.setDidTryPurchasing(true)
                completeRobloxSubscriptionUpsellFlow()
                return
            end
            current.setPromptState(PromptState.SubscriptionPurchaseUIReady)
        end)

        local connection3 = nil
        local connection4 = nil

        if FFlagLuaAppEnableNativePurchaseFinishedV2Signals then
            local var5 = if func3 then func3() else game:GetService("MarketplaceService").NativePurchaseFinishedWithLocalPlayerV2

            connection3 = var5:Connect(function(_, arg1, _)
                local current = var2.current
                if current.getPromptState() ~= PromptState.SubscriptionPurchaseInProgress then
                    return
                end

                if arg1 then
                    current.setDidTryPurchasing(true)
                    completeRobloxSubscriptionUpsellFlow()
                    return
                end
                current.setPromptState(PromptState.SubscriptionPurchaseUIReady)
            end)

            local var6 = if func4 then func4() else game:GetService("MarketplaceService").NativePurchaseFinishedV2

            connection4 = var6:Connect(function(_, _, arg1, _)
                local current = var2.current
                if current.getPromptState() ~= PromptState.SubscriptionPurchaseInProgress then
                    return
                end

                if arg1 then
                    current.setDidTryPurchasing(true)
                    completeRobloxSubscriptionUpsellFlow()
                    return
                end
                current.setPromptState(PromptState.SubscriptionPurchaseUIReady)
            end)
        end

        return function()
            if connection then
                connection:Disconnect()
            end
            if connection2 then
                connection2:Disconnect()
            end
            if connection3 then
                connection3:Disconnect()
            end
            if connection4 then
                connection4:Disconnect()
            end
        end
    end, {
        var3,
        var4,
        func3,
        func4
    })
end

local function useNativePurchaseFinishedListenerWithCancelCallback<T>(func1: ((...any) -> (...any))?, func2: ((...any) -> (...any))?, current: ((...any) -> (...any))?, func3: ((...any) -> (...any))?, func4: ((...any) -> (...any))?)
    local var1 = RobloxSubscriptionStore.get()
    local var2 = React.useRef(var1)
    local var3 = React.useRef(current)
    var3.current = current

    local var4 = React.useMemo(function(): () -> RBXScriptSignal | (...any) -> (...any)
        return func1 or function(): RBXScriptSignal
            return game:GetService("MarketplaceService").NativePurchaseFinishedWithLocalPlayer
        end
    end, { func1 })

    local var5 = React.useMemo(function(): () -> RBXScriptSignal | (...any) -> (...any)
        return func2 or function(): RBXScriptSignal
            return game:GetService("MarketplaceService").NativePurchaseFinished
        end
    end, { func2 })

    local function onNativePurchaseFinished(_: string, bool1: boolean)
        local current2 = var2.current

        if current2.getPromptState() ~= PromptState.SubscriptionPurchaseInProgress then
            return
        end

        if bool1 then
            current2.setDidTryPurchasing(true)
            completeRobloxSubscriptionUpsellFlow()
        elseif var3.current then
            var3.current()
        else
            current2.setPromptState(PromptState.SubscriptionPurchaseUIReady)
        end
    end

    React.useEffect(function()
        local connection = var4():Connect(function(arg1, arg2)
            onNativePurchaseFinished(arg1, arg2)
        end)

        local connection2 = var5():Connect(function(_, arg1, arg2)
            onNativePurchaseFinished(arg1, arg2)
        end)

        local connection3 = nil
        local connection4 = nil

        if FFlagLuaAppEnableNativePurchaseFinishedV2Signals then
            local var6 = if func3 then func3() else game:GetService("MarketplaceService").NativePurchaseFinishedWithLocalPlayerV2

            connection3 = var6:Connect(function(arg1, arg2, _)
                onNativePurchaseFinished(arg1, arg2)
            end)

            local var7 = if func4 then func4() else game:GetService("MarketplaceService").NativePurchaseFinishedV2

            connection4 = var7:Connect(function(_, arg1, arg2, _)
                onNativePurchaseFinished(arg1, arg2)
            end)
        end

        return function()
            if connection then
                connection:Disconnect()
            end
            if connection2 then
                connection2:Disconnect()
            end
            if connection3 then
                connection3:Disconnect()
            end
            if connection4 then
                connection4:Disconnect()
            end
        end
    end, {
        var4,
        var5,
        func3,
        func4
    })
end

local function useNativePurchaseFinishedListener(func1: ((...any) -> (...any))?, func2: ((...any) -> (...any))?, current: ((...any) -> (...any))?, func3: ((...any) -> (...any))?, func4: ((...any) -> (...any))?)
    if FFlagEnableHeadlessSubscriptionNativePurchaseCancelCallback then
        useNativePurchaseFinishedListenerWithCancelCallback(func1, func2, current, func3, func4)
        return
    end

    useNativePurchaseFinishedListenerLegacy(func1, func2, func3, func4)
end

return useNativePurchaseFinishedListener
