-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:10:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local Signals = require(DataHydrationParent.Signals)

local _BuyRobuxStoreTypes = require(script.BuyRobuxStoreTypes)
local createBuyRobuxStore = require(script.createBuyRobuxStore)

return {
    createBuyRobuxStore = createBuyRobuxStore,
    getOneTimeProductStore = Signals.createComputed(function() -- name: createOneTimeProductStore
        return createBuyRobuxStore()
    end),
    getSubscriptionProductStore = Signals.createComputed(function() -- name: createSubscriptionProductStore
        return createBuyRobuxStore()
    end),
    getPendingTransferStore = Signals.createComputed(function() -- name: createPendingTransferStore
        return createBuyRobuxStore()
    end),
    getBonusItemStore = Signals.createComputed(function() -- name: createBonusItemStore
        return createBuyRobuxStore()
    end)
}
