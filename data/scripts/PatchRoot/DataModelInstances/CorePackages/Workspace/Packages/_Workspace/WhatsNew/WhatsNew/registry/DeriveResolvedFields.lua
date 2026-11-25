-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T23:01:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local WhatsNew = script:FindFirstAncestor("WhatsNew")
local Enums = require(WhatsNew.Enums)
local _Types = require(WhatsNew.Types)

local module = {}

local function clientGatesPass(onboarding, arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return not (onboarding == Enums.TourType.Onboarding) or arg1.onboardingEligible
end

local function isNonEmptyString(str1: string?): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return not (str1 == nil) and str1 ~= ""
end

local function isoDateToUnix(isoDate: string): number? -- Luacid: Inlined by compiler; 2 call sites recovered
    local dateTime = DateTime.fromIsoDate(isoDate)
    return dateTime and dateTime.UnixTimestamp or nil
end

function module.isEntryInScopeSubtree(arg1, str1: string, tbl1)
    local scopeId = arg1.scopeId
    while scopeId ~= nil do
        if scopeId == str1 then
            return true
        end
        local var1 = tbl1[scopeId]
        if var1 == nil then
            return false
        end
        scopeId = var1.parentScopeId
    end
    return false
end

function module.isEntryExpired(arg1, onboarding, arg2)
    local var1 = if arg1.publishedTime == nil then nil else isoDateToUnix(arg1.publishedTime)

    if var1 ~= nil and arg2.currentTime < var1 then
        return true
    end

    if onboarding == Enums.TourType.Onboarding then
        return false
    end

    if arg1.disabledTime ~= nil then
        local var2 = isoDateToUnix(arg1.disabledTime)
        if var2 ~= nil and var2 <= arg2.currentTime then
            return true
        end
    end

    return false
end

function module.deriveEntryDisplay(arg1, onboarding, arg2)
    local expired = module.isEntryExpired(arg1, onboarding, arg2)
    local var1 = arg2.storage[arg1.id]
    local seen = if var1 then var1.seen else nil
    local var2 = clientGatesPass(onboarding, arg2)
    local tbl1 = {
        id = arg1.id,
        scopeId = arg1.scopeId,
        title = arg1.title,
        text = arg1.text,
        icon = arg1.icon,
        enabled = arg1.enabled,
        publishedTime = arg1.publishedTime,
        disabledTime = arg1.disabledTime,
        expired = expired,
        seen = seen,
        optOutCount = if var1 then var1.optOutCount else 0,
        adopted = if var1 then var1.adopted else false,
        toShow = 0
    }
    local var3 = arg1.enabled and not expired

    if var3 then
        if seen ~= nil then
            var2 = false
        end
    else
        var2 = var3
    end

    tbl1.toShow = var2
    return tbl1
end

function module.getLabels(arg1, onboarding)
    if onboarding == Enums.TourType.Onboarding then
        return {
            title = arg1.onboardingTitle or "",
            text = arg1.onboardingText or ""
        }
    end

    return {
        title = arg1.updatesTitle or "",
        text = arg1.updatesText or ""
    }
end

function module.hasLabels(arg1): boolean
    return isNonEmptyString(arg1.title) or isNonEmptyString(arg1.text)
end

function module.countScopeSteps(arg1)
    local num1 = 0
    for _, tourTip in arg1.tourTips do
        num1 += tourTip.stepCount
    end
    return num1
end

return module
