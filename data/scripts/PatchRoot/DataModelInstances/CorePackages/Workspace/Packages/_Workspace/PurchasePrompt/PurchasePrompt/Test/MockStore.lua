-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:40:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent
local Rodux = require(PurchasePromptParent.PurchasePromptDeps).Rodux

local Reducer = require(PurchasePrompt.Reducers.Reducer)
local ABTest = require(PurchasePrompt.Services.ABTest)
local Network = require(PurchasePrompt.Services.Network)
local Analytics = require(PurchasePrompt.Services.Analytics)
local PlatformInterface = require(PurchasePrompt.Services.PlatformInterface)
local ExternalSettings = require(PurchasePrompt.Services.ExternalSettings)
local Thunk = require(PurchasePrompt.Thunk)
local PurchaseFlow = require(PurchasePrompt.Enums.PurchaseFlow)

local module = {}

function module.getMockPurchaseFlow(arg1)
    return arg1 or PurchaseFlow.Product
end

function module.getMockNativeUpsell(_: string?, _: string?, _: number?)
    return {
        robuxProductId = "testRobuxProductId",
        productId = "testProductId",
        robuxPurchaseAmount = 500
    }
end

function module.getMockRobuxUpsellSuggestions(products)
    return {
        products = products
            or {{
                providerId = "testRobuxProductId",
                productId = "testProductId",
                robuxAmount = 500,
                robuxAmountBeforeBonus = 450,
                price = "4.99"
            }},
        selection = 1
    }
end

function module.getMockStore()
    local abTest = ABTest.new()
    local network = Network.new()
    local analytics = Analytics.new()
    local platformInterface = PlatformInterface.new()
    local externalSettings = ExternalSettings.new()

    return Rodux.Store.new(Reducer, {}, { Thunk.middleware({
            [ABTest] = abTest,
            [Network] = network,
            [Analytics] = analytics,
            [PlatformInterface] = platformInterface,
            [ExternalSettings] = externalSettings
        }) })
end

return module
