-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:41:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")

local TransferDirection = require(CurrencyTransfers.Enums.TransferDirection)
local PromptState = require(CurrencyTransfers.Enums.PromptState)

local function applyRobuxTransferFlowIngestStubs(tbl1, tbl2)
    local var1 = if tbl2 and tbl2.direction ~= nil then tbl2.direction else TransferDirection.Send

    local function stubIfNil(str1: string, func1: (...any) -> (...any)) -- Luacid: Inlined by compiler; 15 call sites recovered
        if tbl1[str1] == nil then
            tbl1[str1] = func1
        end
    end

    stubIfNil("getDirection", function()
        return var1
    end)
    stubIfNil("getRecipient", function()
        return nil
    end)
    stubIfNil("getRecipientUserId", function(): number
        return 0
    end)
    stubIfNil("getSender", function()
        return nil
    end)
    stubIfNil("getTransferRequestId", function()
        return nil
    end)
    stubIfNil("getSelectedAmount", function()
        return nil
    end)
    stubIfNil("getRobuxTransfer", function()
        return nil
    end)
    stubIfNil("getTransferOrigination", function()
        return nil
    end)
    stubIfNil("getPromptState", function()
        return PromptState.Unspecified
    end)
    stubIfNil("getTransferClientSessionId", function(): string
        return ""
    end)
    stubIfNil("getBalanceReceivedFromApi", function(): boolean
        return false
    end)
    stubIfNil("getRobuxBalanceAmount", function(): number
        return 0
    end)
    stubIfNil("getNetworkImpl", function()
        return nil
    end)
    stubIfNil("triggerOnPromptOptimisticHide", function()
        return nil
    end)
    stubIfNil("triggerOnPromptDismissCommitted", function()
        return nil
    end)
end

return applyRobuxTransferFlowIngestStubs
