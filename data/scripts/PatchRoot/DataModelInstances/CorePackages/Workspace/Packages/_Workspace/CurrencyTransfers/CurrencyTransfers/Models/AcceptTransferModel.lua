-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:40:58Z
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
    arg1 = arg1 or {}
    local transferStatus = require(CurrencyTransfers.Enums.TransferStatus)

    return (module.new({
        robuxTransfer = arg1.robuxTransfer
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
            },
        isAlreadyAccepted = not (arg1.isAlreadyAccepted == nil) and arg1.isAlreadyAccepted
    }))
end

function module.format(arg1)
    local var1 = arg1.robuxTransfer or arg1.RobuxTransfer
    local isAlreadyAccepted = if arg1.isAlreadyAccepted ~= nil then arg1.isAlreadyAccepted else arg1.IsAlreadyAccepted == true
    local transferStatus = require(CurrencyTransfers.Enums.TransferStatus)

    if not var1 then
        error("AcceptTransferModel.format: robuxTransfer is missing from response")
    end

    return (module.new({
        isAlreadyAccepted = isAlreadyAccepted,
        robuxTransfer = {
            transferId = var1.transferId or var1.TransferId,
            sender = {
                type = var1.sender.type or var1.Sender.Type,
                targetId = var1.sender.targetId or var1.Sender.TargetId,
                targetName = var1.sender.targetName or var1.Sender.TargetName,
                targetDisplayName = var1.sender.targetDisplayName or var1.Sender.TargetDisplayName
            },
            recipient = {
                type = var1.recipient.type or var1.Recipient.Type,
                targetId = var1.recipient.targetId or var1.Recipient.TargetId,
                targetName = var1.recipient.targetName or var1.Recipient.TargetName,
                targetDisplayName = var1.recipient.targetDisplayName or var1.Recipient.TargetDisplayName
            },
            transferAmount = var1.transferAmount or var1.TransferAmount,
            receivingAmount = var1.receivingAmount or var1.ReceivingAmount,
            creationTime = var1.creationTime or var1.CreationTime,
            requireRecipientAction = var1.requireRecipientAction or var1.RequireRecipientAction,
            status = transferStatus.fromValue(var1.status or var1.Status) or transferStatus.Completed
        }
    }))
end

module.isValid = t.strictInterface({ robuxTransfer = t.table, isAlreadyAccepted = t.boolean })

return module
