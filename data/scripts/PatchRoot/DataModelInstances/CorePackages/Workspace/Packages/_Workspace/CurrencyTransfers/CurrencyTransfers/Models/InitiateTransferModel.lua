-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:41:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")
local CurrencyTransfersParent = CurrencyTransfers.Parent
local _types = require(CurrencyTransfers.types)
local t = require(CurrencyTransfersParent.t)
local FFlagShowRemainingTransfersForNonPlus = require(CurrencyTransfers.Flags.FFlagShowRemainingTransfersForNonPlus)
local TransferBenefitSource = require(CurrencyTransfers.Enums.TransferBenefitSource)

local module = {}

function module.new<T>(arg1: T): T
    assert(module.isValid(arg1))

    module.__index = module

    setmetatable(arg1, module)

    return arg1
end

function module.mock(arg1)
    arg1 = arg1 or {}
    local robuxTransfer = arg1.robuxTransfer or {}
    local sender = robuxTransfer.sender or {
        targetDisplayName = "MockSender",
        targetId = 0,
        targetName = "mock",
        type = 1
    }

    local recipient = robuxTransfer.recipient or {
        targetDisplayName = "MockRecipient",
        targetId = 0,
        targetName = "mock",
        type = 1
    }

    local userRelationshipDetail = arg1.userRelationshipDetail or {
        mutualFriendsCount = 0,
        userAccountSinceYear = 0,
        areFriends = false
    }

    return (module.new({
        transferRequestId = arg1.transferRequestId or "RXT-1234567890",
        robuxTransfer = {
            transferId = robuxTransfer.transferId or 1234567890,
            sender = sender,
            recipient = recipient
        },
        userRelationshipDetail = userRelationshipDetail,
        senderRobuxBalance = arg1.senderRobuxBalance or 0
    }))
end

function module.format(arg1)
    local robuxTransfer = arg1.robuxTransfer
    local sender = robuxTransfer.sender
    local var1 = sender
        and {
            targetDisplayName = sender.targetDisplayName,
            targetId = sender.targetId,
            targetName = sender.targetName,
            type = sender.type
        }
        or { targetDisplayName = "", targetId = 0, targetName = "", type = 0 }

    return (module.new({
        transferRequestId = arg1.transferRequestId,
        robuxTransfer = {
            transferId = robuxTransfer.transferId,
            sender = var1,
            recipient = {
                targetDisplayName = robuxTransfer.recipient.targetDisplayName,
                targetId = robuxTransfer.recipient.targetId,
                targetName = robuxTransfer.recipient.targetName,
                type = robuxTransfer.recipient.type
            }
        },
        senderRobuxBalance = arg1.senderRobuxBalance,
        minimumTransferAmount = arg1.minimumTransferAmount,
        maximumTransferAmount = arg1.maximumTransferAmount,
        userRelationshipDetail = {
            friendSinceYear = arg1.userRelationshipDetail.friendSinceYear,
            friendSinceDate = arg1.userRelationshipDetail.friendSinceDate,
            mutualFriendsCount = arg1.userRelationshipDetail.mutualFriendsCount,
            userAccountSinceYear = arg1.userRelationshipDetail.userAccountSinceYear,
            areFriends = arg1.userRelationshipDetail.areFriends
        },
        transferBenefitSource = if FFlagShowRemainingTransfersForNonPlus then TransferBenefitSource.fromValue(arg1.benefitSource) else nil,
        numFreeTransfersRemaining = if FFlagShowRemainingTransfersForNonPlus and type(arg1.numFreeTransfersRemaining) == "number" then arg1.numFreeTransfersRemaining else nil
    }))
end
module.isValid = t.strictInterface({
    transferRequestId = t.string,
    robuxTransfer = t.strictInterface({
        transferId = t.number,
        sender = t.strictInterface({ targetDisplayName = t.string, targetId = t.number, targetName = t.string, type = t.number }),
        recipient = t.strictInterface({ targetDisplayName = t.string, targetId = t.number, targetName = t.string, type = t.number })
    }),
    userRelationshipDetail = t.strictInterface({
        friendSinceYear = t.optional(t.number),
        friendSinceDate = t.optional(t.strictInterface({ year = t.number, month = t.number, day = t.number })),
        mutualFriendsCount = t.number,
        userAccountSinceYear = t.number,
        areFriends = t.boolean
    }),
    senderRobuxBalance = t.number,
    minimumTransferAmount = t.optional(t.number),
    maximumTransferAmount = t.optional(t.number),
    transferBenefitSource = t.optional(t.string),
    numFreeTransfersRemaining = t.optional(t.number)
})

return module
