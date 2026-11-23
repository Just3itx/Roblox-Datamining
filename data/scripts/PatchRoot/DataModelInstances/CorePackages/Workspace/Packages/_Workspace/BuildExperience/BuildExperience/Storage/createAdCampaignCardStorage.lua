-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:51:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local FFlagBuildAgentAdCampaignCard = require(BuildExperience.Flags.FFlagBuildAgentAdCampaignCard)

local tbl1 = {
    creating = true,
    processing = true,
    created = true,
    active = true,
    retryable_error = true,
    outcome_unknown = true,
    payment_required = true,
    failed = true
}

local function isNonemptyString(arg1): boolean -- Luacid: Inlined by compiler; 9 call sites recovered
    return type(arg1) == "string" and arg1 ~= ""
end

local function isCount(arg1): boolean -- Luacid: Inlined by compiler; 10 call sites recovered
    return type(arg1) == "number" and arg1 >= 0 and arg1 < math.huge and arg1 % 1 == 0
end

local function isRecord(arg1, sessionId: string, toolCallId: string)
    if type(arg1) ~= "table" then
        return false
    end

    local var1

    if arg1.sessionId == sessionId and arg1.toolCallId == toolCallId then
        var1 = isNonemptyString(sessionId) and isNonemptyString(toolCallId) and isCount(arg1.universeId)

        if var1 then
            if arg1.universeId > 0 then
                var1 = isNonemptyString(arg1.idempotencyKey) and (arg1.campaignOption == nil or isNonemptyString(arg1.campaignOption))

                if var1 then
                    if arg1.fundingType == "free" or arg1.fundingType == "paid" then
                        local phase, bool1

                        if arg1.durationDays == nil and arg1.displayAmountRobux == nil then
                            phase = arg1.phase

                            if type(phase) == "string" and tbl1[arg1.phase] == true then
                                if arg1.phase == "active" or arg1.phase == "created" then
                                    bool1 = isNonemptyString(arg1.campaignId)
                                else
                                    bool1 = arg1.campaignId == nil
                                end

                                var1 = bool1 and (arg1.campaignStatus == nil or isNonemptyString(arg1.campaignStatus))

                                if var1 then
                                    if (arg1.lastErrorCode == nil
                                        or type(arg1.lastErrorCode) == "string"
                                        or type(arg1.lastErrorCode) == "number" and math.abs(arg1.lastErrorCode) < math.huge)
                                        and (arg1.lastErrorMessage == nil or type(arg1.lastErrorMessage) == "string")
                                    then
                                        var1 = isCount(arg1.createdAtMs) and isCount(arg1.updatedAtMs) and arg1.updatedAtMs >= arg1.createdAtMs
                                    else
                                        var1 = false
                                    end
                                end
                            else
                                var1 = false
                            end

                            return var1
                        end

                        var1 = isCount(arg1.durationDays)

                        if var1 then
                            if arg1.durationDays > 0 then
                                var1 = isCount(arg1.displayAmountRobux)

                                if var1 then
                                    phase = arg1.phase

                                    if type(phase) == "string" and tbl1[arg1.phase] == true then
                                        if arg1.phase == "active" or arg1.phase == "created" then
                                            bool1 = isNonemptyString(arg1.campaignId)
                                        else
                                            bool1 = arg1.campaignId == nil
                                        end

                                        var1 = bool1 and (arg1.campaignStatus == nil or isNonemptyString(arg1.campaignStatus))

                                        if var1 then
                                            if (arg1.lastErrorCode == nil
                                                or type(arg1.lastErrorCode) == "string"
                                                or type(arg1.lastErrorCode) == "number" and math.abs(arg1.lastErrorCode) < math.huge)
                                                and (arg1.lastErrorMessage == nil or type(arg1.lastErrorMessage) == "string")
                                            then
                                                var1 = isCount(arg1.createdAtMs) and isCount(arg1.updatedAtMs) and arg1.updatedAtMs >= arg1.createdAtMs
                                            else
                                                var1 = false
                                            end
                                        end
                                    else
                                        var1 = false
                                    end

                                    return var1
                                end
                            else
                                var1 = false
                            end
                        end
                    else
                        var1 = false
                    end
                end
            else
                var1 = false
            end
        end
    else
        var1 = false
    end

    return var1
end

local function readRecord(tbl2) -- Luacid: Inlined by compiler; 4 call sites recovered
    local var1 = table.clone(tbl2)

    if var1.phase == "active" then
        var1.phase = "created"
    end
    return var1
end

local function isDurableAttempt(tbl2): boolean
    local bool1 = isCount(tbl2.userId)

    if bool1 then
        if tbl2.userId > 0 then
            bool1 = isCount(tbl2.attemptStartedAtMs)

            if bool1 then
                if type(tbl2.hasAmbiguousFailure) == "boolean"
                    and (tbl2.campaignOption == "feedback" or tbl2.campaignOption == "plays")
                    and tbl2.durationDays ~= nil
                then
                    bool1 = tbl2.displayAmountRobux ~= nil
                else
                    bool1 = false
                end
            end
        else
            bool1 = false
        end
    end

    return bool1
end

local function sameAttempt(tbl2, tbl3): boolean
    if tbl2.userId == tbl3.userId
        and tbl2.universeId == tbl3.universeId
        and tbl2.idempotencyKey == tbl3.idempotencyKey
        and tbl2.campaignOption == tbl3.campaignOption
        and tbl2.fundingType == tbl3.fundingType
        and tbl2.durationDays == tbl3.durationDays
        and tbl2.displayAmountRobux == tbl3.displayAmountRobux
        and tbl2.createdAtMs == tbl3.createdAtMs
    then
        return tbl2.attemptStartedAtMs == tbl3.attemptStartedAtMs
    end

    return false
end

local function readNamespace(arg1)
    local adCampaignCards = arg1.adCampaignCards
    if adCampaignCards == nil then
        return {
            sessions = {}
        }, nil
    elseif type(adCampaignCards) ~= "table" or type(adCampaignCards.sessions) ~= "table" then
        return nil, "malformed_storage"
    end
    return adCampaignCards, nil
end

local function createAdCampaignCardStorage(tbl2)
    local function readData() -- Luacid: unused: defined but never referenced
        local success, result, result2 = pcall(tbl2.readData)
        return success and result == true, result2
    end
    local function writeData(arg1): boolean -- Luacid: Inlined by compiler; 3 call sites recovered
        local success, result = pcall(tbl2.writeData, arg1)
        return success and result == true
    end
    local var1 = nil
    local tbl3 = ({})

    local tbl4 = ({})

    local tbl5 = {}

    local function beforeUnsentPreflight(str1: string, str2: string, tbl6)
        local var2 = if tbl5[str1] == nil then nil else tbl5[str1][str2]

        if var2 ~= nil and tbl6 ~= nil then
            local staged = var2.staged

            if sameAttempt(staged, tbl6)
                and tbl6.phase == staged.phase
                and tbl6.updatedAtMs == staged.updatedAtMs
                and tbl6.hasAmbiguousFailure == staged.hasAmbiguousFailure
                and tbl6.lastErrorCode == staged.lastErrorCode
            then
                return var2.previous, true
            end
        end
        return tbl6, false
    end

    local function load() -- Luacid: Inlined by compiler; 2 call sites recovered
        if var1 ~= nil then
            return var1, nil
        end

        local success, result, result2 = pcall(tbl2.readData)
        if not success or result ~= true then
            return nil, "storage_unavailable"
        end
        local var2, var3 = readNamespace(result2)
        var1 = var2
        return var2, var3
    end

    local function get(sessionId: string, toolCallId: string)
        local var2 = if tbl3[sessionId] == nil then nil else tbl3[sessionId][toolCallId]

        if var2 ~= nil then
            return {
                isAvailable = true,
                isPersisted = false,
                record = readRecord(var2)
            }
        end

        local var3 = if tbl4[sessionId] == nil then nil else tbl4[sessionId][toolCallId]

        if var3 ~= nil then
            return {
                isAvailable = true,
                isPersisted = false,
                record = readRecord(var3)
            }
        end

        local var4, errorCode = load()

        if var4 == nil or not (isNonemptyString(sessionId) and isNonemptyString(toolCallId)) then
            return {
                isAvailable = false,
                isPersisted = false,
                errorCode = errorCode or "invalid_identity"
            }
        end

        local session = var4.sessions[sessionId]
        if session ~= nil and type(session) ~= "table" then
            return { isAvailable = false, isPersisted = false, errorCode = "malformed_session" }
        end

        local var6 = if session == nil then nil else session[toolCallId]

        if var6 ~= nil
            and (not isRecord(var6, sessionId, toolCallId)
                or FFlagBuildAgentAdCampaignCard and var6.userId ~= nil and not isDurableAttempt(var6))
        then
            return { isAvailable = false, isPersisted = false, errorCode = "malformed_record" }
        end

        local var7

        if FFlagBuildAgentAdCampaignCard then
            var6, var7 = beforeUnsentPreflight(sessionId, toolCallId, var6)
        else
            var7 = false
        end
        return {
            isAvailable = true,
            isPersisted = not var7,
            record = if var6 == nil then nil else readRecord(var6)
        }
    end

    local function retryWrites(): boolean
        if next(tbl3) == nil then
            return true
        end

        local success, result, result2 = pcall(tbl2.readData)
        if not success or result ~= true then
            return false
        end
        local var2 = readNamespace(result2)
        if var2 == nil then
            return false
        end
        local adCampaignCards = table.clone(var2)
        adCampaignCards.sessions = table.clone(var2.sessions)
        local tbl6 = ({})
        local bool1 = false
        for value, value2 in tbl3 do
            local session = adCampaignCards.sessions[value]
            if session ~= nil and type(session) ~= "table" then
                tbl6[value] = {}
                for value3 in value2 do
                    tbl6[value][value3] = true
                end
            else
                local var4 = session == nil and {} or table.clone(session)
                for value3, value4 in value2 do
                    local var5 = var4[value3]
                    if var5 ~= nil and not isRecord(var5, value, value3)
                        or var5 ~= nil
                            and (var5.universeId ~= value4.universeId
                                or var5.updatedAtMs > value4.updatedAtMs
                                or var5.campaignId ~= nil and var5.campaignId ~= value4.campaignId
                                or FFlagBuildAgentAdCampaignCard and value4.userId ~= nil and not sameAttempt(var5, value4))
                    then
                        tbl6[value] = tbl6[value] or {}
                        tbl6[value][value3] = true
                    else
                        var4[value3] = table.clone(value4)
                        bool1 = true
                    end
                end

                adCampaignCards.sessions[value] = var4
            end
        end

        for value, value2 in tbl6 do
            for value3 in value2 do
                local var4 = tbl4[value] or {}
                var4[value3] = table.clone(tbl3[value][value3])
                tbl4[value] = var4
                tbl3[value][value3] = nil
            end
            if next(tbl3[value]) == nil then
                tbl3[value] = nil
            end
        end
        if not bool1 then
            return next(tbl6) == nil
        end
        local var4 = table.clone(result2)
        var4.adCampaignCards = adCampaignCards

        if not writeData(var4) then
            return false
        end
        var1 = adCampaignCards
        table.clear(tbl3)
        return next(tbl6) == nil
    end

    local function retain(tbl6)
        if not isRecord(tbl6, tbl6.sessionId, tbl6.toolCallId) then
            return false, false
        end
        local var2 = tbl3[tbl6.sessionId] or {}
        var2[tbl6.toolCallId] = table.clone(tbl6)
        tbl3[tbl6.sessionId] = var2
        return retryWrites(), true
    end

    return {
        get = get,
        list = function(sessionId: string)
            if not isNonemptyString(sessionId) then
                return {
                    isAvailable = false,
                    records = {},
                    errorCode = "invalid_identity"
                }
            end

            local var2, var3 = load()
            local session = if var2 == nil then nil else var2.sessions[sessionId]

            if session ~= nil and type(session) ~= "table" then
                session = nil
                var3 = "malformed_session"
            end

            local var4 = session == nil and {} or table.clone(session)
            for value, value2 in tbl4[sessionId] or {} do
                var4[value] = value2
            end
            for value, value2 in tbl3[sessionId] or {} do
                var4[value] = value2
            end
            local records = {}
            for value, value2 in var4 do
                if not isRecord(value2, sessionId, value)
                    or FFlagBuildAgentAdCampaignCard and value2.userId ~= nil and not isDurableAttempt(value2)
                then
                    continue
                end

                if FFlagBuildAgentAdCampaignCard then
                    value2 = beforeUnsentPreflight(sessionId, value, value2)
                end
                if value2 ~= nil then
                    table.insert(records, (readRecord(value2)))
                end
            end

            table.sort(records, function(tbl7, tbl8): boolean
                if tbl7.createdAtMs == tbl8.createdAtMs then
                    return tbl7.toolCallId < tbl8.toolCallId
                end

                return tbl7.createdAtMs < tbl8.createdAtMs
            end)

            return {
                isAvailable = var3 == nil,
                records = records,
                errorCode = var3
            }
        end,
        confirm = function(tbl6)
            if not isRecord(tbl6, tbl6.sessionId, tbl6.toolCallId) or tbl6.phase ~= "created" then
                return false, false
            end
            local var2 = get(tbl6.sessionId, tbl6.toolCallId)
            local record = var2.record
            if FFlagBuildAgentAdCampaignCard and tbl6.userId ~= nil then
                if not isDurableAttempt(tbl6) then
                    return false, false
                end

                if record == nil and not var2.isAvailable then
                    return retain(tbl6)
                end
                if record == nil or not sameAttempt(record, tbl6) then
                    return false, false
                end
            end
            if record ~= nil and record.campaignId ~= nil then
                if record.campaignId == tbl6.campaignId then
                    return retryWrites() and get(tbl6.sessionId, tbl6.toolCallId).isPersisted, false
                end
                return false, false
            end

            return retain(tbl6)
        end,
        saveAttempt = function(tbl6, idempotencyKey: string?)
            if not isRecord(tbl6, tbl6.sessionId, tbl6.toolCallId) or not isDurableAttempt(tbl6) or tbl6.campaignId ~= nil then
                return false
            end

            local var2 = get(tbl6.sessionId, tbl6.toolCallId)
            if var2.record ~= nil and var2.record.campaignId ~= nil then
                return false
            end

            local success, result, result2 = pcall(tbl2.readData)
            local var3 = if success and result == true then readNamespace(result2) else nil

            if var3 == nil then
                return false
            end
            local session = var3.sessions[tbl6.sessionId]
            if session ~= nil and type(session) ~= "table" then
                return false
            end

            local var4 = if session == nil then nil else session[tbl6.toolCallId]

            if var4 ~= nil
                and (not isRecord(var4, tbl6.sessionId, tbl6.toolCallId)
                    or not isDurableAttempt(var4)
                    or var4.campaignId ~= nil
                    or var4.userId ~= tbl6.userId
                    or var4.universeId ~= tbl6.universeId)
            then
                return false
            end

            local var5 = beforeUnsentPreflight(tbl6.sessionId, tbl6.toolCallId, var4)
            if var5 ~= nil then
                if var5.idempotencyKey == tbl6.idempotencyKey then
                    local bool1

                    if tbl6.idempotencyKey == tbl6.toolCallId and idempotencyKey == var5.idempotencyKey then
                        bool1 = not var5.hasAmbiguousFailure

                        if bool1 then
                            if var5.phase == "failed" or var5.phase == "payment_required" then
                                bool1 = tbl6.phase == "creating"
                            else
                                bool1 = false
                            end
                        end
                    else
                        bool1 = false
                    end
                    if not (sameAttempt(var5, tbl6) or bool1) or var5.hasAmbiguousFailure and not tbl6.hasAmbiguousFailure then
                        return false
                    end
                elseif var5.idempotencyKey ~= idempotencyKey
                    or var5.hasAmbiguousFailure
                    or var5.phase ~= "failed" and var5.phase ~= "payment_required"
                then
                    return false
                end
            elseif idempotencyKey ~= nil and idempotencyKey ~= tbl6.idempotencyKey then
                return false
            end
            local adCampaignCards = table.clone(var3)
            adCampaignCards.sessions = table.clone(var3.sessions)
            local var7 = table.clone(session or {})
            var7[tbl6.toolCallId] = table.clone(tbl6)
            adCampaignCards.sessions[tbl6.sessionId] = var7
            local var8 = table.clone(result2)
            var8.adCampaignCards = adCampaignCards
            var1 = nil

            if writeData(var8) then
                if tbl5[tbl6.sessionId] ~= nil then
                    tbl5[tbl6.sessionId][tbl6.toolCallId] = nil
                end
                var1 = adCampaignCards
                return true
            end

            if tbl6.phase == "creating" then
                local var9 = tbl5[tbl6.sessionId] or {}
                local toolCallId = tbl6.toolCallId
                var9[toolCallId] = {
                    staged = table.clone(tbl6),
                    previous = if var5 == nil then nil else table.clone(var5)
                }
                tbl5[tbl6.sessionId] = var9
            end
            return false
        end,
        hasPendingWrites = function(): boolean
            return next(tbl3) ~= nil
        end,
        retryWrites = retryWrites,
        prune = function(tbl6): (boolean, boolean)
            if next(tbl3) ~= nil or not (isCount(tbl6.nowMs) and isCount(tbl6.retentionMs) and isCount(tbl6.maxRecords)) then
                return false, false
            end

            local success, result, result2 = pcall(tbl2.readData)
            if not success or result ~= true then
                return false, false
            end
            local var2 = readNamespace(result2)
            if var2 == nil then
                return false, false
            end
            local tbl7 = {}
            local num1 = 0
            for k, session in var2.sessions do
                if type(session) ~= "table" then
                    continue
                end

                local var3 = tbl6.loadedToolCallIdsBySession[k]
                for value, value2 in session do
                    if not isRecord(value2, k, value) or value2.universeId ~= tbl6.universeId then
                        continue
                    end

                    num1 += 1
                    local bool1 = not (value2.campaignId == nil or tbl6.settledCampaignIds[value2.campaignId] ~= true or var3 == nil) and not var3[value]

                    if tbl6.nowMs - value2.updatedAtMs > tbl6.retentionMs and bool1 then
                        table.insert(tbl7, value2)
                    end
                end
            end
            if num1 <= tbl6.maxRecords or #tbl7 == 0 then
                return true, false
            end
            table.sort(tbl7, function(tbl8, tbl9): boolean
                if tbl8.updatedAtMs == tbl9.updatedAtMs then
                    if tbl8.sessionId == tbl9.sessionId then
                        return tbl8.toolCallId < tbl9.toolCallId
                    end

                    return tbl8.sessionId < tbl9.sessionId
                end

                return tbl8.updatedAtMs < tbl9.updatedAtMs
            end)

            local adCampaignCards = table.clone(var2)
            adCampaignCards.sessions = table.clone(var2.sessions)
            local var4 = num1 - tbl6.maxRecords
            local num2 = #tbl7

            for i = 1, math.min(var4, num2) do
                local var5 = tbl7[i]
                local var6 = table.clone(adCampaignCards.sessions[var5.sessionId])
                var6[var5.toolCallId] = nil
                adCampaignCards.sessions[var5.sessionId] = var6
            end
            local var5 = table.clone(result2)
            var5.adCampaignCards = adCampaignCards

            if not writeData(var5) then
                return false, false
            end
            var1 = adCampaignCards
            return true, true
        end,
        reset = function()
            var1 = nil
            table.clear(tbl3)
            table.clear(tbl4)
            table.clear(tbl5)
        end
    }
end

return createAdCampaignCardStorage
