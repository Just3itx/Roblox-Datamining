-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:30:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local IAPExperience = script:FindFirstAncestor("IAPExperience")
local EconomicRestrictionsViolationType = require(IAPExperience.Enums.EconomicRestrictionsViolationType)

local logger = require(IAPExperience.Utility.logger)

return function(tbl1, violationType)
    if violationType == EconomicRestrictionsViolationType.Chargeback then
        return tbl1.chargebackViolationLabel
    end

    if violationType == EconomicRestrictionsViolationType.AbuseOfAffiliateSystem then
        return tbl1.fraudAbuseOfAffiliateSystemViolationLabel
    end

    if violationType == EconomicRestrictionsViolationType.AttemptedUnauthorizedPaymentMethodUse then
        return tbl1.fraudAttemptedUnauthorizedPaymentMethodUseViolationLabel
    end

    if violationType == EconomicRestrictionsViolationType.PaymentAuthorizationAttempt then
        return tbl1.fraudPaymentAbuseViolationLabel
    end

    if violationType == EconomicRestrictionsViolationType.RepeatedRefundRequests then
        return tbl1.fraudRepeatedRefundRequestsViolationLabel
    end

    if violationType == EconomicRestrictionsViolationType.SuspiciousAccountPatterns then
        return tbl1.fraudSuspiciousAccountPatternsViolationLabel
    end

    if violationType == EconomicRestrictionsViolationType.SuspiciousRefundRequests then
        return tbl1.fraudSuspiciousRefundRequestsViolationLabel
    end

    if violationType == EconomicRestrictionsViolationType.UnauthorizedPurchase then
        return tbl1.fraudUnauthorizedPurchaseViolationLabel
    end

    if violationType == EconomicRestrictionsViolationType.UseOfUnauthorizedOffPlatformTransactions then
        return tbl1.fraudUseOfUnauthorizedOffPlatformTransactionsViolationLabel
    end

    if violationType == EconomicRestrictionsViolationType.VirtualEconomyAbuse then
        return tbl1.fraudVirtualEconomyAbuseViolationLabel
    end

    logger.error({ message = "Invalid violation type", violationType = violationType })

    return ""
end
