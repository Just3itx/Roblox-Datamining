-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:11:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent
local React = require(InExperienceShopParent.React)
local SignalsReact = require(InExperienceShopParent.SignalsReact)

local FFlagEnableShopPrefetch = require(InExperienceShop.Flags.FFlagEnableShopPrefetch)
local FFlagEnableFreeTrialBlueDot = require(InExperienceShop.Flags.FFlagEnableFreeTrialBlueDot)
local getInExperienceShopStore = require(InExperienceShop.Stores.getInExperienceShopStore)
local logCounter = require(InExperienceShop.Internal.logCounter)
local ShopDebugLogger = require(InExperienceShop.Internal.ShopDebugLogger)
local FirstOpenCounter = require(InExperienceShop.Events.FirstOpenCounter)
local FirstOpenPrefetchHitCounter = require(InExperienceShop.Events.FirstOpenPrefetchHitCounter)
local OpenCounter = require(InExperienceShop.Events.OpenCounter)
local ShopView = require(script.Parent.ShopView)
local useShopViewModel = require(script.Parent.useShopViewModel)

local bool1 = false

local function ShopContainer(arg1)
    local var1 = SignalsReact.useSignalState(getInExperienceShopStore)

    React.useEffect(function()
        local var2 = FFlagEnableShopPrefetch and not bool1
        ShopDebugLogger.logLazy(function(): string
            return "ShopContainer: mount isFirstOpen=" .. tostring(var2)
        end)
        logCounter(OpenCounter)
        if var2 then
            bool1 = true
            logCounter(FirstOpenCounter)

            local bool2 = #var1.getCategories(false) > 0
            ShopDebugLogger.logLazy(function(): string
                return "ShopContainer: prefetch cache hit=" .. tostring(bool2)
            end)
            if bool2 then
                logCounter(FirstOpenPrefetchHitCounter)
            end
        end

        if FFlagEnableFreeTrialBlueDot then
            require(InExperienceShop.submitFreeTrialBlueDot).dismiss()
        end

        local notificationsOrchestrator = require(InExperienceShopParent.NotificationsOrchestrator)
        notificationsOrchestrator.setInExperienceShopOpen(true)
        task.spawn(function()
            ShopDebugLogger.log("ShopContainer: calling onShopOpened")
            var1.onShopOpened()
        end)
        return function()
            notificationsOrchestrator.setInExperienceShopOpen(false)
        end
    end, { var1.onShopOpened, var1.getCategories })

    local var2 = useShopViewModel(arg1)
    return React.createElement(ShopView, var2)
end

return ShopContainer
