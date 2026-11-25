-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:30:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent
local Rodux = require(PurchasePromptParent.PurchasePromptDeps).Rodux

local AccountInfoReceived = require(PurchasePrompt.Actions.AccountInfoReceived)
local BalanceInfoRecieved = require(PurchasePrompt.Actions.BalanceInfoRecieved)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[AccountInfoReceived.name] = function(arg1, arg2)
    local accountInfo = arg2.accountInfo

    return {
        balance = arg1.balance,
        membershipType = if accountInfo.isPremium then 4 else 0
    }
end

tbl1[BalanceInfoRecieved.name] = function(arg1, arg2)
    local balanceInfo = arg2.balanceInfo
    return {
        balance = balanceInfo.robux,
        hasFailed = balanceInfo.hasFailed,
        membershipType = arg1.membershipType
    }
end

return (createReducer({}, tbl1))
