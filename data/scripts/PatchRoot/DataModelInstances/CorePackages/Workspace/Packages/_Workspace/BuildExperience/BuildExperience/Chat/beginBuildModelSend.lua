-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T18:51:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local CreatorAgentChat = require(BuildExperienceParent.DataHydration.CreatorAgentChat)
local FFlagBuildExperienceAdvancedPreviewSpecs = require(BuildExperienceParent.SharedFlags).FFlagBuildExperienceAdvancedPreviewSpecs
local _CreatorCredit = require(BuildExperienceParent.DataHydration.CreatorCredit)
local _createBuildModelSelectionStore = require(BuildExperience.Stores.GetBuildModelSelectionStore.createBuildModelSelectionStore)
local chatConstants = require(script.Parent.chatConstants)

local function isAvailable(arg1, id) -- Luacid: Inlined by compiler; 2 call sites recovered
    if arg1 == nil then
        return id == "default"
    end
    for _, value in arg1.available do
        if value.id == id then
            return true
        end
    end
    return false
end

local function awaitRefreshedQuota(arg1, tier, func1: (...any) -> (...any))
    local getTierQuotaSummarySignals = arg1.getTierQuotaSummarySignals
    local refreshTierQuotaSummary = arg1.refreshTierQuotaSummary
    if getTierQuotaSummarySignals == nil or refreshTierQuotaSummary == nil then
        return nil
    end
    local var1 = getTierQuotaSummarySignals("PRODUCT_BUILD", tier).data(false)
    local var2 = refreshTierQuotaSummary("PRODUCT_BUILD", tier)
    local var3 = os.clock() + chatConstants.CAS_RPC_TIMEOUT_SECONDS
    while func1() and os.clock() < var3 do
        local var4 = var2.status(false)
        if var4 == "Failed" then
            return nil
        end
        local var5 = var2.data(false)
        if var4 == "Ready" and var5 ~= nil and var5 ~= var1 then
            return var5
        end
        task.wait()
    end
    return nil
end

local function beginBuildModelSend(arg1, arg2, arg3, tbl1)
    if arg1 == nil then
        return nil
    end
    local var1 = arg1.acquireLock()
    if var1 == nil then
        return nil
    end

    local isSelected = not (tbl1 == nil) and tbl1.isSelected
    local str1 = if FFlagBuildExperienceAdvancedPreviewSpecs then if tbl1 == nil then "default" elseif tbl1.previewSpecName == "build-on-mobile-advanced" then "advanced" else "default" else "default"

    local captureSendConfiguration = CreatorAgentChat.captureSendConfiguration
    if not isSelected then
        str1 = assert(arg1.getSelection(false)).intendedTier
    end

    local sendConfiguration = captureSendConfiguration(str1, arg3)

    local bool1 = false
    local bool2 = false
    local var3 = nil
    local var4 = nil
    local function isCurrent(): boolean -- Luacid: Inlined by compiler; 4 call sites recovered
        local bool3 = not bool1
        return bool3 and arg1.getSelection(false) ~= nil and (var3 == nil or var3.getCasSessionId() == var4)
    end

    local function release() -- Luacid: Inlined by compiler; 1 call site recovered
        if not bool1 then
            bool1 = true
            arg1.releaseLock(var1)
        end
    end
    return {
        prepare = function(arg4)
            assert(not bool2, "A model send attempt can only prepare once")
            bool2 = true

            if not isCurrent() then
                return nil, nil
            end
            local bool3 = arg4.getCasSessionId() == nil
            if bool3 then
                arg1.restoreTier(sendConfiguration.tier)
            end
            local sessionId, setupError = arg4.prepareSession({
                sendConfiguration = sendConfiguration,
                isCancelled = function(): boolean
                    return not isCurrent()
                end
            })

            if not isCurrent() then
                return nil, nil
            elseif sessionId == nil and setupError == nil then
                release()
                return nil, nil
            elseif sessionId == nil or arg4.getCasSessionId() ~= sessionId then
                return nil, {
                    kind = "setup",
                    errorCode = if setupError == nil then nil else setupError.errorCode,
                    reason = if setupError == nil then nil else setupError.fundingReason,
                    setupError = setupError
                }
            else
                var3 = arg4
                var4 = sessionId
                local models = arg4.getModels(false)
                if not bool3 and models ~= nil then
                    arg1.restoreTier(models.current)
                end

                local var7 = if bool3 or isSelected == true then sendConfiguration.tier else assert(arg1.getSelection(false)).intendedTier
                arg1.restoreTier(var7)
                local bool4

                if models == nil then
                    bool4 = not not isAvailable(nil, var7)
                else
                    bool4 = false

                    for _, value in models.available do
                        if value.id == var7 then
                            bool4 = true
                            break
                        end
                    end
                end

                if not bool4 then
                    return nil, { kind = "unavailable" }
                end
                local var8 = table.freeze({
                    tier = var7,
                    experiment = sendConfiguration.experiment,
                    sessionId = sessionId,
                    universeId = arg4.universeId,
                    placeId = arg4.placeId
                })
                local var9 = awaitRefreshedQuota(arg2, var8.tier, isCurrent)

                if not isCurrent() then
                    return nil, nil
                elseif var9 == nil or var9.allowed == nil then
                    return nil, { kind = "quota" }
                elseif not var9.allowed then
                    return nil, {
                        kind = "denied",
                        errorCode = CreatorAgentChat.ErrorCodes.OutOfCredits,
                        reason = var9.reason
                    }
                else
                    local models2 = arg4.getModels(false)
                    local tier = var8.tier
                    local bool5

                    if models2 == nil then
                        bool5 = not not isAvailable(nil, tier)
                    else
                        bool5 = false

                        for _, value in models2.available do
                            if value.id == tier then
                                bool5 = true
                                break
                            end
                        end
                    end

                    if not bool5 then
                        return nil, { kind = "unavailable" }
                    end
                    return var8, nil
                end
            end
        end,
        isCurrent = isCurrent,
        release = release,
        unlockSelection = function()
            arg1.releaseLock(var1)
        end
    }
end

return beginBuildModelSend
