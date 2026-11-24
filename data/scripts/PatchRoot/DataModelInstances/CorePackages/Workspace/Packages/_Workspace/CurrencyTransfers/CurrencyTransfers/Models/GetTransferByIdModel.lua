-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:41:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")
local CurrencyTransfersParent = CurrencyTransfers.Parent
local _types = require(CurrencyTransfers.types)
local t = require(CurrencyTransfersParent.t)

local module = {}

function module.new<T>(arg1: T): T
    assert(module.isValid(arg1))

    module.__index = module

    setmetatable(arg1, module)

    return arg1
end

function module.mock(arg1)
    local transferStatus = require(CurrencyTransfers.Enums.TransferStatus)
    return (module.new({
        transfer = (arg1 or {}).transfer
            or {
                transferId = 123456,
                sender = {
                    type = 1,
                    targetId = 100,
                    targetName = "SenderUser",
                    targetDisplayName = "Sender Display"
                },
                recipient = {
                    type = 1,
                    targetId = 200,
                    targetName = "RecipientUser",
                    targetDisplayName = "Recipient Display"
                },
                transferAmount = 100,
                creationTime = "2025-01-01T00:00:00Z",
                requireRecipientAction = false,
                status = transferStatus.Completed
            }
    }))
end

local function formatRobuxTransfer(transfer)
    local transferStatus = require(CurrencyTransfers.Enums.TransferStatus)
    local sender = transfer.sender
    local recipient = transfer.recipient
    return {
        transferId = transfer.transferId,
        sender = {
            type = sender.type,
            targetId = sender.targetId,
            targetName = sender.targetName,
            targetDisplayName = sender.targetDisplayName
        },
        recipient = {
            type = recipient.type,
            targetId = recipient.targetId,
            targetName = recipient.targetName,
            targetDisplayName = recipient.targetDisplayName
        },
        transferAmount = transfer.transferAmount,
        creationTime = transfer.creationTime,
        requireRecipientAction = transfer.requireRecipientAction,
        status = transferStatus.fromValue(transfer.status) or transferStatus.Completed
    }
end

function module.format(arg1)
    local transfer = arg1.transfer
    if not transfer then
        error("GetTransferByIdModel.format: transfer is missing from response")
    end

    return (module.new({ transfer = formatRobuxTransfer(transfer) }))
end

module.isValid = t.strictInterface({ transfer = t.table })

return module
