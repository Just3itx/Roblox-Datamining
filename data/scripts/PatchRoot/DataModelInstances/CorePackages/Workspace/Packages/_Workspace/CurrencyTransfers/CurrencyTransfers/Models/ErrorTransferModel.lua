-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:40:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")
local CurrencyTransfersParent = CurrencyTransfers.Parent
local t = require(CurrencyTransfersParent.t)

local FailureReason = require(CurrencyTransfers.Enums.FailureReason)

local GetFFlagEnableLimitHit2SVUpsell = require(CurrencyTransfers.Flags.GetFFlagEnableLimitHit2SVUpsell)

local module = {}

function module.new<T>(arg1: T): T
    assert(module.isValid(arg1))

    module.__index = module

    setmetatable(arg1, module)

    return arg1
end

function module.mock(arg1)
    arg1 = arg1 or {}

    return (module.new({
        failureReason = arg1.failureReason,
        errorMessage = arg1.errorMessage or "",
        ampRecourseActions = arg1.ampRecourseActions,
        ampFeatureCheck = arg1.ampFeatureCheck
    }))
end

function module.format(arg1)
    local var1 = arg1.FailureReason or arg1.failureReason
    local errorMessage = arg1.ErrorMessage or arg1.errorMessage or ""
    local ampRecourseActions = arg1.AmpRecourseActions or arg1.ampRecourseActions
    local ampFeatureCheck = arg1.AmpFeatureCheck or arg1.ampFeatureCheck

    local var5 = nil
    if GetFFlagEnableLimitHit2SVUpsell() then
        if arg1.IsEligibleForElevatedLimitUpsell ~= nil then
            var5 = arg1.IsEligibleForElevatedLimitUpsell
        elseif arg1.isEligibleForElevatedLimitUpsell ~= nil then
            var5 = arg1.isEligibleForElevatedLimitUpsell
        end
    end

    local failureReason = FailureReason.fromValue(var1)

    return (module.new({
        failureReason = failureReason,
        errorMessage = errorMessage,
        ampRecourseActions = ampRecourseActions,
        ampFeatureCheck = ampFeatureCheck,
        isEligibleForElevatedLimitUpsell = var5
    }))
end
module.isValid = t.strictInterface({
    failureReason = t.optional(t.string),
    errorMessage = t.string,
    ampRecourseActions = t.optional(t.array(t.string)),
    ampFeatureCheck = t.optional(t.string),
    isEligibleForElevatedLimitUpsell = t.optional(t.boolean)
})

return module
