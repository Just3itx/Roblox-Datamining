-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:10:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UniversalFeatureRestrictions = script:FindFirstAncestor("UniversalFeatureRestrictions")
local UniversalFeatureRestrictionsParent = UniversalFeatureRestrictions.Parent

local _AbuseVector = require(UniversalFeatureRestrictions.Common.AbuseVector)
local _Types = require(UniversalFeatureRestrictionsParent.ModerationCommon.Types)
local showFeatureRestriction = require(UniversalFeatureRestrictions.Utils.showFeatureRestriction)
local showFeatureRestrictionDirect = require(UniversalFeatureRestrictions.Utils.showFeatureRestrictionDirect)

local function hasContent(arg1): boolean -- Luacid: Inlined by compiler; 3 call sites recovered
    return type(arg1) == "string" and arg1 ~= ""
end

local function buildEndDate(tbl1)
    if tbl1.type == "nudge" then
        return "", 0
    end

    local timeoutStartTime = tbl1.timeoutStartTime
    local timeoutDurationSeconds = tbl1.timeoutDurationSeconds
    if not timeoutStartTime or timeoutStartTime == "" or not timeoutDurationSeconds or timeoutDurationSeconds < 0 then
        return nil, nil
    elseif timeoutDurationSeconds == 0 then
        return "", timeoutDurationSeconds
    else
        local dateTime = DateTime.fromIsoDate(timeoutStartTime)
        if not dateTime then
            return nil, nil
        end

        return DateTime.fromUnixTimestamp(dateTime.UnixTimestamp + timeoutDurationSeconds):ToIsoDate(), timeoutDurationSeconds
    end
end

local function buildModerationDetail(tbl1, endDate: string, duration: number)
    return {
        punishedUserId = 0,
        interventionId = "",
        punishmentId = 0,
        messageToUser = "",
        title = tbl1.title,
        body = tbl1.body,
        punishmentTypeDescription = tbl1.type,
        beginDate = tbl1.timeoutStartTime or "",
        endDate = endDate,
        badUtterances = {},
        context = {},
        verificationCategory = "",
        consequenceTransparencyMessage = "",
        showAppealsProcessLink = false,
        isForeshadowingConsequenceEnabled = false,
        violation = nil,
        duration = duration,
        acknowledgeable = false,
        showUGCAvatarGuidelinesLink = false,
        labelTranslationKey = ""
    }
end

local function showFeatureRestrictionFromRealtime(arg1, tbl1, arg2)
    if tbl1.acknowledgeable
        or tbl1.type ~= "nudge" and tbl1.type ~= "timeout"
        or not (hasContent(tbl1.decisionEventId) and hasContent(tbl1.title) and hasContent(tbl1.body))
    then
        showFeatureRestriction(arg1, arg2)
        return
    end

    local endDate, var1 = buildEndDate(tbl1)
    if endDate == nil or var1 == nil then
        showFeatureRestriction(arg1, arg2)
        return
    end

    local var2 = table.clone(arg2 or {})
    var2.analyticsEventId = tbl1.decisionEventId

    showFeatureRestrictionDirect(arg1, buildModerationDetail(tbl1, endDate, var1), var2)
end

return showFeatureRestrictionFromRealtime
