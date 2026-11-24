-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:40:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _types = require(script.Parent.types)
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent
local FFlagBuildExperienceModelPickerData = require(DataHydrationParent.SharedFlags).FFlagBuildExperienceModelPickerData

local tbl1 = {
    BLOCK_REASON_FREE_TRIAL_EXHAUSTED = "FreeTrialExhausted",
    BLOCK_REASON_DAILY_LIMIT_REACHED = "DailyLimitReached",
    BLOCK_REASON_INSUFFICIENT_ROBUX_BALANCE = "InsufficientRobuxBalance",
    "InsufficientRobuxBalance",
    "DailyLimitReached",
    "FreeTrialExhausted"
}

local tbl2 = {
    MODEL_TIER_DEFAULT = "default",
    MODEL_TIER_ADVANCED = "advanced",
    "default",
    "advanced"
}

local tbl3 = {
    FREE_TRIAL_RESET_PERIOD_DAILY = "Daily",
    FREE_TRIAL_RESET_PERIOD_WEEKLY = "Weekly",
    FREE_TRIAL_RESET_PERIOD_MONTHLY = "Monthly"
}

local function decodeNumber(arg1): number -- Luacid: Inlined by compiler; 7 call sites recovered
    if typeof(arg1) == "number" then
        return arg1
    elseif typeof(arg1) == "string" then
        return tonumber(arg1) or 0
    end

    return 0
end

local function decodeDailyLimitSettings(arg1)
    local var1 = typeof(arg1) ~= "table" and {} or arg1
    if typeof(var1.limitSettings) == "table" then
        var1 = var1.limitSettings
    end

    return {
        additionalUsageEnabled = var1.additionalUsageEnabled == true,
        dailyLimitSet = var1.dailyLimitSet == true,
        dailyLimit = decodeNumber(var1.dailyLimit)
    }
end

local function decodeQuotaBlockReason(reason) -- Luacid: Inlined by compiler; 1 call site recovered
    return if typeof(reason) == "string" then tbl1[reason] else nil
end

local function decodeFreeTrialResetPeriod(freeTrialResetPeriod) -- Luacid: Inlined by compiler; 1 call site recovered
    return if typeof(freeTrialResetPeriod) == "string" then tbl3[freeTrialResetPeriod] or "Daily" else "Daily"
end

local function decodeModelTier(modelTier) -- Luacid: Inlined by compiler; 1 call site recovered
    return if typeof(modelTier) == "string" or typeof(modelTier) == "number" then tbl2[modelTier] else nil
end

local function decodeOptionalRobux(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    if typeof(arg1) ~= "number" and typeof(arg1) ~= "string" then
        return nil
    end
    local var1 = tonumber(arg1)
    return if var1 == nil or var1 < 0 or var1 > 9007199254740991 or var1 % 1 ~= 0 then nil else var1
end

local function decodeQuotaSummary(arg1)
    local var1 = typeof(arg1) ~= "table" and {} or arg1
    if typeof(var1.summary) == "table" then
        var1 = var1.summary
    end

    local tbl4 = {
        freeTrialDailyAllowance = decodeNumber(var1.freeTrialDailyAllowance),
        freeTrialRemaining = decodeNumber(var1.freeTrialRemaining),
        freeTrialPctUsed = decodeNumber(var1.freeTrialPctUsed),
        nextResetEligibleTime = var1.nextResetEligibleTime or "",
        robuxBalance = decodeNumber(var1.robuxBalance),
        limitSettings = decodeDailyLimitSettings(var1.limitSettings),
        robuxSpentToday = decodeNumber(var1.robuxSpentToday),
        limitRemaining = decodeNumber(var1.limitRemaining),
        allowed = if typeof(var1.allowed) == "boolean" then var1.allowed else nil,
        reason = decodeQuotaBlockReason(var1.reason),
        freeTrialResetPeriod = decodeFreeTrialResetPeriod(var1.freeTrialResetPeriod)
    }
    if FFlagBuildExperienceModelPickerData then
        local blockDetails = var1.blockDetails
        if typeof(blockDetails) == "table" then
            tbl4.blockDetails = {
                modelTier = decodeModelTier(blockDetails.modelTier),
                requiredRobux = decodeOptionalRobux(blockDetails.requiredRobux),
                availableRobux = decodeOptionalRobux(blockDetails.availableRobux)
            }
        end
    end
    return tbl4
end

return {
    decodeDailyLimitSettings = decodeDailyLimitSettings,
    decodeQuotaSummary = decodeQuotaSummary,
    decodeTierQuotaSummary = function(arg1)
        local tbl4 = decodeQuotaSummary(arg1)
        local summary = if typeof(arg1) == "table" then arg1.summary else nil

        if typeof(summary) == "table" then
            if summary.allowed == nil then
                tbl4.allowed = false
            end
            if typeof(summary.reason) == "number" then
                tbl4.reason = tbl1[summary.reason]
            end
        end
        return tbl4
    end
}
