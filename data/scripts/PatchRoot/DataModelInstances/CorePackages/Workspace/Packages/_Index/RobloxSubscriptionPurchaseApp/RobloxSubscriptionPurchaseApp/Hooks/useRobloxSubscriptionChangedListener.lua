-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:50:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxSubscriptionPurchaseApp = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp")
local Players = game:GetService("Players")

local RobloxSubscriptionPurchaseAppParent = RobloxSubscriptionPurchaseApp.Parent

local React = require(RobloxSubscriptionPurchaseAppParent.React)

local RobloxSubscriptionStore = require(RobloxSubscriptionPurchaseApp.Store.RobloxSubscriptionStore)
local finalizeRobloxSubscriptionUpsellFlow = require(RobloxSubscriptionPurchaseApp.Actions.finalizeRobloxSubscriptionUpsellFlow)
local PromptState = require(RobloxSubscriptionPurchaseApp.Enums.PromptState)

local function useRobloxSubscriptionChangedListener(func1: ((...any) -> (...any))?)
    local var1 = RobloxSubscriptionStore.get()
    local var2 = React.useRef(var1)

    local var3 = React.useMemo(function(): () -> Player | (...any) -> (...any)
        return func1 or function(): Player
            return Players.LocalPlayer
        end
    end, { func1 })

    React.useEffect(function()
        local var4 = var3()
        if not var4 then
            return nil
        end

        local function onHasRobloxSubscriptionChanged()
            if var4.HasRobloxSubscription ~= true then
                return
            end

            if var2.current.getPromptState() == PromptState.SubscriptionStatusPolling then
                finalizeRobloxSubscriptionUpsellFlow(true)
            end
        end

        local connection = var4:GetPropertyChangedSignal("HasRobloxSubscription"):Connect(onHasRobloxSubscriptionChanged)

        return function()
            if connection then
                connection:Disconnect()
            end
        end
    end, { var3 })
end

return useRobloxSubscriptionChangedListener
