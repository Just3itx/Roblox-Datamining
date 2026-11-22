-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:30:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local IAPExperience = script:FindFirstAncestor("IAPExperience")
local CheckUserPurchaseSettingsFailureReason = require(IAPExperience.Enums.CheckUserPurchaseSettingsFailureReason)

local EconomicRestrictionsViolationType = require(IAPExperience.Enums.EconomicRestrictionsViolationType)

return function(arg1)
    if arg1 == CheckUserPurchaseSettingsFailureReason.Chargeback then
        return EconomicRestrictionsViolationType.Chargeback
    end

    if arg1 == CheckUserPurchaseSettingsFailureReason.AbuseOfAffiliateSystem then
        return EconomicRestrictionsViolationType.AbuseOfAffiliateSystem
    end

    if arg1 == CheckUserPurchaseSettingsFailureReason.AttemptedUnauthorizedPaymentMethodUse then
        return EconomicRestrictionsViolationType.AttemptedUnauthorizedPaymentMethodUse
    end

    if arg1 == CheckUserPurchaseSettingsFailureReason.PaymentAuthorizationAttempt then
        return EconomicRestrictionsViolationType.PaymentAuthorizationAttempt
    end

    if arg1 == CheckUserPurchaseSettingsFailureReason.RepeatedRefundRequests then
        return EconomicRestrictionsViolationType.RepeatedRefundRequests
    end

    if arg1 == CheckUserPurchaseSettingsFailureReason.SuspiciousAccountPatterns then
        return EconomicRestrictionsViolationType.SuspiciousAccountPatterns
    end

    if arg1 == CheckUserPurchaseSettingsFailureReason.SuspiciousRefundRequests then
        return EconomicRestrictionsViolationType.SuspiciousRefundRequests
    end

    if arg1 == CheckUserPurchaseSettingsFailureReason.UnauthorizedPurchase then
        return EconomicRestrictionsViolationType.UnauthorizedPurchase
    end

    if arg1 == CheckUserPurchaseSettingsFailureReason.UseOfUnauthorizedOffPlatformTransactions then
        return EconomicRestrictionsViolationType.UseOfUnauthorizedOffPlatformTransactions
    end

    if arg1 == CheckUserPurchaseSettingsFailureReason.VirtualEconomyAbuse then
        return EconomicRestrictionsViolationType.VirtualEconomyAbuse
    end

    return EconomicRestrictionsViolationType.None
end
