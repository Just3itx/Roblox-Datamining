-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:41:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")

local TransferDirection = require(CurrencyTransfers.Enums.TransferDirection)
local _createTransferStore = require(CurrencyTransfers.Stores.createTransferStore)

local function getCounterUserId(arg1, send)
    if send == TransferDirection.Send then
        local recipient = arg1.getRecipient(false)
        if recipient then
            return recipient.targetId
        end
    else
        local sender = arg1.getSender(false)
        if sender then
            return sender.targetId
        end
    end
    return nil
end

return getCounterUserId
