-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:10:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UniversalFeatureRestrictions = script:FindFirstAncestor("UniversalFeatureRestrictions")
local UniversalFeatureRestrictionsParent = UniversalFeatureRestrictions.Parent

local _AbuseVector = require(UniversalFeatureRestrictions.Common.AbuseVector)
local featureRestrictionDisplayDirectSignal = require(UniversalFeatureRestrictions.Signals.featureRestrictionDisplayDirectSignal)
local GetModerationDetail = require(UniversalFeatureRestrictions.Http.GetModerationDetail)
local _Types = require(UniversalFeatureRestrictionsParent.ModerationCommon.Types)
local _showFeatureRestrictionDirect = require(UniversalFeatureRestrictions.Utils.showFeatureRestrictionDirect)

local num1 = game:DefineFastInt("UFRRunUnlessFeatureRestrictedTimeoutMs", 2000)

local function isNudge(moderationDetail): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local punishmentTypeDescription = moderationDetail.punishmentTypeDescription
    return type(punishmentTypeDescription) == "string" and string.find(punishmentTypeDescription:lower(), "nudge", 1, true) ~= nil
end

local function expectsAcknowledgement(moderationDetail): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local interventionId = moderationDetail.interventionId
    return moderationDetail.acknowledgeable == true and type(interventionId) == "string" and interventionId ~= ""
end

local function runUnlessFeatureRestricted(abuseVector, tbl1)
    local bool1 = false
    local bool2 = false
    local var1 = nil

    local function setPhase(str1: string) -- Luacid: Inlined by compiler; 11 call sites recovered
        if tbl1.onPhaseChanged then
            tbl1.onPhaseChanged(str1)
        end
    end

    local function settle() -- Luacid: Inlined by compiler; 7 call sites recovered
        if bool2 then
            return
        end
        bool2 = true
        setPhase("Settled")
    end

    local function proceed(str1: string) -- Luacid: Inlined by compiler; 8 call sites recovered
        if bool1 then
            return
        end
        bool1 = true
        task.spawn(function()
            tbl1.onProceed(str1)
        end)
    end

    local function restrict(str1: string) -- Luacid: Inlined by compiler; 3 call sites recovered
        if bool1 then
            return
        end
        bool1 = true
        local onRestricted = tbl1.onRestricted
        if onRestricted then
            task.spawn(function()
                onRestricted(str1)
            end)
        end
    end

    local function failOpen() -- Luacid: Inlined by compiler; 4 call sites recovered
        settle()
        proceed("CheckFailed")
    end

    local function showDialog(moderationDetail)
        local bool3 = isNudge(moderationDetail)
        local bool4 = bool3 and expectsAcknowledgement(moderationDetail)
        local bool5 = false
        local bool6 = false
        local str1 = nil

        local function evaluate()
            if not bool5 then
                return
            end

            if bool6 and bool4 and str1 == nil then
                setPhase("Acknowledging")
                return
            end

            settle()

            if not bool3 then
                restrict("ActiveRestriction")
            elseif str1 == "Succeeded" then
                proceed("Nudged")
            elseif str1 == "Failed" then
                restrict("NudgeAcknowledgementFailed")
            elseif not bool6 then
                restrict("NudgeDismissedUnacknowledged")
            else
                proceed("Nudged")
            end
        end

        local options = table.clone(tbl1.dialogOptions or {})
        local onAcknowledgementSuccess = options.onAcknowledgementSuccess
        local onAcknowledgementFailure = options.onAcknowledgementFailure
        function options.onAcknowledgementSuccess()
            str1 = "Succeeded"
            evaluate()
            if onAcknowledgementSuccess then
                onAcknowledgementSuccess()
            end
        end
        function options.onAcknowledgementFailure()
            str1 = "Failed"
            evaluate()
            if onAcknowledgementFailure then
                onAcknowledgementFailure()
            end
        end

        local bool7 = false

        local success, result = pcall(function()
            featureRestrictionDisplayDirectSignal:fire({
                abuseVector = abuseVector,
                moderationDetail = moderationDetail,
                options = options,
                onHandled = function()
                    bool7 = true
                end,
                onClosed = function(bool8: boolean)
                    if bool5 then
                        return
                    end
                    bool5 = true
                    bool6 = bool8
                    evaluate()
                end
            })
        end)
        if not success then
            warn(`runUnlessFeatureRestricted: a listener failed while showing the dialog: {result}`)
        end

        if not bool7 then
            failOpen()
            return
        end

        setPhase("ShowingDialog")
        evaluate()
    end

    setPhase("Checking")
    local bool3 = false
    local moderationDetail = GetModerationDetail({ abuseVector = abuseVector })

    var1 = task.delay(tbl1.timeoutSeconds or num1 / 1000, function()
        var1 = nil
        if bool3 then
            return
        end
        bool3 = true
        moderationDetail:cancel()
        failOpen()
    end)

    local function finishCheck(): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
        if bool3 then
            return false
        end
        bool3 = true
        if var1 then
            task.cancel(var1)
            var1 = nil
        end
        return true
    end

    moderationDetail:andThen(function(arg1)
        if not finishCheck() then
            return
        end

        if arg1 == nil or type(arg1) == "table" and next(arg1) == nil then
            settle()
            proceed("Clear")
        elseif type(arg1) ~= "table" then
            failOpen()
        else
            showDialog(arg1)
        end
    end, function()
        if finishCheck() then
            failOpen()
        end
    end)
end

return runUnlessFeatureRestricted
