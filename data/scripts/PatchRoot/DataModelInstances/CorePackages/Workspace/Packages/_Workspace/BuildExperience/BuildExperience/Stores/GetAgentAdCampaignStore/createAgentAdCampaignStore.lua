-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:00:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local HttpService = game:GetService("HttpService")
local _Signals = require(BuildExperienceParent.Signals)
local SignalsUtils = require(BuildExperienceParent.SignalsUtils)
local _CreatorAgentChat = require(BuildExperienceParent.DataHydration.CreatorAgentChat)
local _createAdCampaignCardStorage = require(BuildExperience.Storage.createAdCampaignCardStorage)
local FFlagBuildAgentAdCampaignRefreshEligibility = require(BuildExperience.Flags.FFlagBuildAgentAdCampaignRefreshEligibility)

local function hasToolCallIdempotency(arg1): boolean -- Luacid: Inlined by compiler; 4 call sites recovered
    return arg1.idempotencyKey == arg1.toolCallId
end

local function isWithinReplayWindow(arg1): boolean -- Luacid: Inlined by compiler; 3 call sites recovered
    local var1 = DateTime.now().UnixTimestampMillis - (arg1.attemptStartedAtMs or 0)
    return var1 >= 0 and var1 < 82800000
end

local function isDefinitiveFailure(arg1): boolean -- Luacid: Inlined by compiler; 5 call sites recovered
    local bool1 = not arg1.isPending
    return bool1 and arg1.hasAmbiguousFailure == false and arg1.failureKind ~= nil and arg1.failureKind ~= "unknown"
end

local function canReplaceRejectedAttempt(arg1): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return isDefinitiveFailure(arg1) and arg1.failureKind ~= "payment_required"
end

local function getRetrySelection(arg1, unixTimestampMillis: number)
    if not hasToolCallIdempotency(arg1) then
        if isWithinReplayWindow(arg1) or not isDefinitiveFailure(arg1) then
            return arg1
        end

        local var1 = table.clone(arg1)
        local unixTimestampMillis2 = DateTime.now().UnixTimestampMillis
        local num1 = unixTimestampMillis2 - unixTimestampMillis
        if num1 >= 0 and num1 < 82800000 then
            unixTimestampMillis2 = unixTimestampMillis
        end

        var1.runStartTimeMs = unixTimestampMillis2
        return var1
    end

    local dateTime = DateTime.now()
    local var1 = dateTime:ToLocalTime()
    local var2 = DateTime.fromUnixTimestampMillis(arg1.runStartTimeMs):ToLocalTime()
    if var2.Year == var1.Year and var2.Month == var1.Month and var2.Day == var1.Day then
        return arg1
    end
    local var3 = DateTime.fromUnixTimestampMillis(unixTimestampMillis):ToLocalTime()
    local var4 = table.clone(arg1)
    if var3.Year ~= var1.Year or var3.Month ~= var1.Month or var3.Day ~= var1.Day then
        unixTimestampMillis = dateTime.UnixTimestampMillis
    end

    var4.runStartTimeMs = unixTimestampMillis

    return var4
end

local function getRetryOffers(arg1, arg2)
    if canReplaceRejectedAttempt(arg1) then
        return arg2
    end
    local campaignOption = arg1.selectedOption.campaignOption
    local offer = arg1.offers[campaignOption]
    local var1 = arg2[campaignOption]
    return if offer == nil
        or var1 == nil
        or var1.fundingType ~= arg1.selectedOption.paymentType
        or var1.durationDays ~= offer.durationDays
        or var1.priceRobux ~= offer.priceRobux then nil else {
        [campaignOption] = var1
    }
end

local function toRecord(arg1)
    local selectedOption = arg1.selectedOption
    local var1 = if selectedOption.campaignOption == "feedback" then arg1.offers.feedback else arg1.offers.plays
    assert(var1 ~= nil, "A submitted campaign must have an offer")
    return {
        sessionId = arg1.sessionId,
        universeId = arg1.universeId,
        toolCallId = arg1.toolCallId,
        idempotencyKey = arg1.idempotencyKey,
        userId = arg1.userId,
        attemptStartedAtMs = arg1.attemptStartedAtMs,
        hasAmbiguousFailure = arg1.hasAmbiguousFailure,
        campaignOption = selectedOption.campaignOption,
        fundingType = selectedOption.paymentType,
        durationDays = var1.durationDays,
        displayAmountRobux = var1.priceRobux,
        phase = if arg1.isPending then "creating" elseif arg1.hasAmbiguousFailure or arg1.failureKind == nil or arg1.failureKind == "unknown" then "outcome_unknown" elseif arg1.failureKind == "payment_required" then "payment_required" else "failed",
        lastErrorCode = arg1.failureKind,
        createdAtMs = arg1.runStartTimeMs,
        updatedAtMs = math.max(arg1.runStartTimeMs, DateTime.now().UnixTimestampMillis)
    }
end

local function createAgentAdCampaignStore()
    local getAttempts, var2 = SignalsUtils.createSessionScopedSignal({})

    local var3, var4 = SignalsUtils.createSessionScopedSignal({})

    local function start(tbl1, arg1, userId: number?, bool1: boolean?): {attemptStartedAtMs: number, failureKind: nil, hasAmbiguousFailure: number, idempotencyKey: number, isPending: boolean, offers: number, runStartTimeMs: number, selectedOption: number, sessionId: any, toolCallId: any, universeId: any, userId: number}?
        local var5 = getAttempts(false)
        local var6 = var5[tbl1.toolCallId]
        local bool2 = not bool1

        if bool2 then
            if var6 == nil or var6.selectedOption.campaignOption ~= arg1.campaignOption then
                bool2 = false
            else
                bool2 = var6.selectedOption.paymentType == arg1.paymentType
            end
        end

        if var6 ~= nil
            and (var6.isPending
                or var6.universeId ~= tbl1.universeId
                or var6.sessionId ~= tbl1.sessionId
                or var6.toolCallId ~= tbl1.toolCallId
                or not bool2 and (var6.failureKind == nil or var6.failureKind == "unknown"))
        then
            return nil
        end

        local var7 = if var6 == nil or not bool2 then tbl1 else var6
        local tbl2 = {
            universeId = var7.universeId,
            sessionId = var7.sessionId,
            toolCallId = var7.toolCallId,
            offers = {
                feedback = if var7.offers.feedback == nil then nil else table.clone(var7.offers.feedback),
                plays = if var7.offers.plays == nil then nil else table.clone(var7.offers.plays)
            },
            runStartTimeMs = var7.runStartTimeMs,
            selectedOption = table.clone(arg1),
            idempotencyKey = if var6 ~= nil and (bool2 or hasToolCallIdempotency(var6)) then var6.idempotencyKey elseif var6 == nil and userId ~= nil then tbl1.toolCallId else HttpService:GenerateGUID(false),
            isPending = true,
            failureKind = nil,
            userId = userId,
            attemptStartedAtMs = if userId == nil then nil elseif var6 ~= nil and bool2 then var6.attemptStartedAtMs else DateTime.now().UnixTimestampMillis,
            hasAmbiguousFailure = if userId == nil then nil else not (var6 == nil) and bool2 and var6.hasAmbiguousFailure == true
        }

        local var8 = table.clone(var5)
        var8[tbl1.toolCallId] = tbl2
        var2(var8)
        return tbl2
    end

    local function finish(arg1, bool1: boolean, failureKind, hasAmbiguousFailure: boolean?): boolean -- Luacid: Inlined by compiler; 1 call site recovered
        local var5 = getAttempts(false)
        if var5[arg1.toolCallId] ~= arg1 then
            return false
        end
        local var6 = table.clone(var5)
        if bool1 then
            var6[arg1.toolCallId] = nil
        else
            local var7 = table.clone(arg1)
            var7.isPending = false
            var7.failureKind = failureKind
            if hasAmbiguousFailure ~= nil then
                var7.hasAmbiguousFailure = hasAmbiguousFailure
            end
            var6[arg1.toolCallId] = var7
        end
        var2(var6)
        return true
    end

    local function restore(tbl1, userId: number, tbl2): boolean
        local var5 = tbl2.get(tbl1.sessionId, tbl1.toolCallId)
        if not var5.isAvailable then
            return false
        end
        local var6 = getAttempts(false)[tbl1.toolCallId]
        if var6 ~= nil and (var6.userId ~= userId or var6.sessionId ~= tbl1.sessionId or var6.universeId ~= tbl1.universeId) then
            return false
        end
        local record = var5.record
        if record == nil then
            return true
        end

        if record.campaignId ~= nil
            or record.userId ~= userId
            or record.universeId ~= tbl1.universeId
            or type(record.attemptStartedAtMs) ~= "number"
            or type(record.hasAmbiguousFailure) ~= "boolean"
            or record.campaignOption ~= "feedback" and record.campaignOption ~= "plays"
            or record.durationDays == nil
            or record.displayAmountRobux == nil
        then
            return false
        end
        if var6 ~= nil and var6.idempotencyKey == record.idempotencyKey then
            return true
        end
        if var6 ~= nil and var6.isPending then
            return false
        end
        local offers = table.clone(tbl1.offers)
        offers[record.campaignOption] = {
            campaignOption = record.campaignOption,
            fundingType = record.fundingType,
            durationDays = record.durationDays,
            priceRobux = record.displayAmountRobux
        }
        local str1 = "unknown"
        if not record.hasAmbiguousFailure and (record.phase == "failed" or record.phase == "payment_required") then
            local lastErrorCode = record.lastErrorCode
            if lastErrorCode == "payment_required"
                or lastErrorCode == "ineligible"
                or lastErrorCode == "missing_thumbnail"
                or lastErrorCode == "invalid_offer"
            then
                str1 = lastErrorCode
            end
        end

        local tbl3 = {
            universeId = record.universeId,
            sessionId = record.sessionId,
            toolCallId = record.toolCallId,
            offers = offers,
            runStartTimeMs = record.createdAtMs,
            selectedOption = {
                campaignOption = record.campaignOption,
                paymentType = record.fundingType
            },
            idempotencyKey = record.idempotencyKey,
            isPending = false,
            failureKind = str1,
            userId = userId,
            attemptStartedAtMs = record.attemptStartedAtMs,
            hasAmbiguousFailure = str1 == "unknown"
        }
        local var8 = table.clone(getAttempts(false))
        var8[tbl1.toolCallId] = tbl3
        var2(var8)
        return true
    end

    return {
        getAttempts = getAttempts,
        getRetrySelection = getRetrySelection,
        getRetryOffers = getRetryOffers,
        canReplaceRejectedAttempt = canReplaceRejectedAttempt,
        start = start,
        finish = finish,
        restore = restore,
        startDurable = function(tbl1, arg1, userId: number, tbl2)
            if not restore(tbl1, userId, tbl2) then
                return nil
            end
            local var5 = getAttempts(false)[tbl1.toolCallId]
            local bool1 = false
            if var5 ~= nil then
                local hasAmbiguousFailure = var5.hasAmbiguousFailure
                local var6

                if FFlagBuildAgentAdCampaignRefreshEligibility then
                    var6 = canReplaceRejectedAttempt(var5)
                    hasAmbiguousFailure = not var6
                else
                    var6 = false
                end

                if not (hasToolCallIdempotency(var5) or isWithinReplayWindow(var5)) then
                    if not isDefinitiveFailure(var5) then
                        return nil
                    end
                    if tbl1.runStartTimeMs ~= getRetrySelection(var5, tbl1.runStartTimeMs).runStartTimeMs then
                        return nil
                    end

                    bool1 = true
                end

                if hasAmbiguousFailure
                    and (var5.selectedOption.campaignOption ~= arg1.campaignOption or var5.selectedOption.paymentType ~= arg1.paymentType)
                then
                    return nil
                end
                if var6 then
                    bool1 = true
                end
            end

            local var6 = start(tbl1, arg1, userId, bool1)
            if var6 == nil then
                return nil
            end
            local save = tbl2.save

            if not save(toRecord(var6), if var5 == nil then nil else var5.idempotencyKey) then
                if getAttempts(false)[var6.toolCallId] == var6 then
                    local var7 = table.clone(getAttempts(false))
                    var7[var6.toolCallId] = var5
                    var2(var7)
                end
                return nil
            end
            if getAttempts(false)[var6.toolCallId] ~= var6 then
                return nil
            end

            if hasToolCallIdempotency(var6) or isWithinReplayWindow(var6) then
                return var6
            end

            local var7 = getAttempts(false)
            if var7[var6.toolCallId] == var6 then
                local var8 = table.clone(var7)

                local var9 = table.clone(var6)
                var9.isPending = false
                var9.failureKind = "unknown"

                var9.hasAmbiguousFailure = true

                var8[var6.toolCallId] = var9

                var2(var8)
            end

            return nil
        end,
        finishDurable = function(arg1, failureKind, tbl1)
            if getAttempts(false)[arg1.toolCallId] ~= arg1 then
                return false
            end
            local var5 = table.clone(arg1)
            var5.isPending = false
            var5.failureKind = failureKind
            var5.hasAmbiguousFailure = arg1.hasAmbiguousFailure == true or failureKind == nil or failureKind == "unknown"

            tbl1.save(toRecord(var5), arg1.idempotencyKey)
            return finish(arg1, false, failureKind, var5.hasAmbiguousFailure)
        end,
        completeDurable = function(arg1)
            local var5 = getAttempts(false)[arg1.toolCallId]
            if var5 == nil
                or var5.userId ~= arg1.userId
                or var5.sessionId ~= arg1.sessionId
                or var5.universeId ~= arg1.universeId
                or var5.idempotencyKey ~= arg1.idempotencyKey
            then
                return
            end

            local var6 = getAttempts(false)
            if var6[var5.toolCallId] ~= var5 then
                return
            end
            local var7 = table.clone(var6)

            var7[var5.toolCallId] = nil

            var2(var7)
        end,
        toRecord = toRecord,
        markImpressed = function(str1: string, str2: string): boolean
            local var5 = var3(false)
            if var5[str1] ~= nil and var5[str1][str2] then
                return false
            end
            local var6 = table.clone(var5)
            var6[str1] = table.clone(var5[str1] or {})
            var6[str1][str2] = true
            var4(var6)
            return true
        end,
        reset = function()
            var2({})
            var4({})
        end
    }
end

return createAgentAdCampaignStore
