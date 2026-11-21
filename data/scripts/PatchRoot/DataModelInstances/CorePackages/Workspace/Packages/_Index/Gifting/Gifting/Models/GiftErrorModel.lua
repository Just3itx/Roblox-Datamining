-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:30:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Gifting = script:FindFirstAncestor("Gifting")
local GiftingParent = Gifting.Parent

local t = require(GiftingParent.t)

local AmpRecourseAction = require(Gifting.Enums.AmpRecourseAction)
local FailureReason = require(Gifting.Enums.FailureReason)
local GiftModelUtils = require(Gifting.Models.GiftModelUtils)
local _Types = require(Gifting.Types)

local function formatInvalidItems(invalidItems)
    if not t.table(invalidItems) then
        return nil
    end

    local result = {}
    for _, invalidItem in invalidItems do
        local var1 = if t.table(invalidItem) then GiftModelUtils.formatItem(invalidItem.item) else nil

        if var1 ~= nil then
            table.insert(result, { item = var1, reason = invalidItem.reason })
        end
    end

    return result
end

local module = {}

function module.format(arg1, status: number?, errorMessage: string?)
    return {
        failureReason = FailureReason.fromValue(arg1.failureReason),
        ampFeatureCheck = arg1.ampFeatureCheck,
        ampRecourseActions = AmpRecourseAction.fromValues(arg1.ampRecourseActions),
        invalidItems = formatInvalidItems(arg1.invalidItems),
        purchaseGiftRequest = arg1.purchaseGiftRequest,
        acceptGiftRequest = arg1.acceptGiftRequest,
        status = status,
        errorMessage = errorMessage
    }
end

function module.invalidRequest(errorMessage: string?)
    return {
        failureReason = FailureReason.InvalidInput,
        errorMessage = errorMessage
    }
end

return module
