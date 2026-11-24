-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T23:40:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local _LinkingProtocolTypes = require(scriptParent.LinkingProtocolTypes)
local AttributionTelemetry = require(scriptParent.AttributionTelemetry)
local getFFlagEnableStartAttributionTelemetry = require(scriptParent.Flags.getFFlagEnableStartAttributionTelemetry)
local getFFlagAdConsentSkipOptOutAuthPublish = require(scriptParent.Flags.getFFlagAdConsentSkipOptOutAuthPublish)
local FFlagAdConsentForwardCachedRegion = require(scriptParentParent.SharedFlags).FFlagAdConsentForwardCachedRegion

local module = {}

local tbl1 = {
    AT = true,
    BE = true,
    BG = true,
    CY = true,
    CZ = true,
    DE = true,
    DK = true,
    EE = true,
    ES = true,
    FI = true,
    FR = true,
    GR = true,
    HR = true,
    HU = true,
    IE = true,
    IT = true,
    LT = true,
    LU = true,
    LV = true,
    MT = true,
    NL = true,
    PL = true,
    PT = true,
    RO = true,
    SE = true,
    SI = true,
    SK = true,
    IS = true,
    LI = true,
    NO = true,
    GB = true,
    CH = true
}

local function isSubjectToGdpr(str1: string?): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return str1 == nil
        or (if FFlagAdConsentForwardCachedRegion and string.match(str1, "^%a%a$") == nil then true else tbl1[string.upper(str1)] == true)
end

local function toDmaConsent(consented: boolean, str1: string?) -- Luacid: Inlined by compiler; 1 call site recovered
    return {
        isSubjectToGdpr = isSubjectToGdpr(str1),
        consented = consented
    }
end

function module.computeDecision(consented: boolean?, str1: string?): {applySharingFilter: boolean, dmaConsent: nil} | {applySharingFilter: boolean, dmaConsent: {consented: boolean, isSubjectToGdpr: boolean}}
    return if consented == nil then { applySharingFilter = true, dmaConsent = nil } else {
        applySharingFilter = not consented,
        dmaConsent = toDmaConsent(consented, str1)
    }
end

local function shouldPublish(arg1, bool1: boolean?): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return not getFFlagAdConsentSkipOptOutAuthPublish() or arg1 ~= "Auth" or bool1 ~= false or false
end

local function isAwaitingConsent(bool1: boolean?): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return bool1 == nil
end

function module.resolveAndPublish(arg1, arg2, consented: boolean?, str1: string?)
    if not shouldPublish(arg2, consented) or isAwaitingConsent(consented) then
        return
    end

    local var1 = module.computeDecision(consented, str1)
    arg1:adConsentResolved(var1)
    if getFFlagEnableStartAttributionTelemetry() then
        AttributionTelemetry.logDecisionPublished(arg2, var1.applySharingFilter)
    end
end

return module
