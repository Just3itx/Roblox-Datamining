-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:21:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local SharedFlags = require(DataHydrationParent.SharedFlags)
local Signals = require(DataHydrationParent.Signals)

local _types = require(script.Parent.Parent.types)
local sendConfiguration = require(script.Parent.Parent.sendConfiguration)

local FFlagBuildExperienceModelPickerData = SharedFlags.FFlagBuildExperienceModelPickerData
local FFlagBuildExperiencePromptFailureTelemetry = SharedFlags.FFlagBuildExperiencePromptFailureTelemetry
local FFlagBuildExperienceLibrary = SharedFlags.FFlagBuildExperienceLibrary
local FFlagBuildExperienceChatOpenId = SharedFlags.FFlagBuildExperienceChatOpenId

return {
    createSendPrompt = function(tbl1)
        return {
            sendPrompt = function(arg1)
                local sendChatOpenId = if FFlagBuildExperienceChatOpenId and tbl1.getSendChatOpenId ~= nil then tbl1.getSendChatOpenId() else nil
                local var1 = if FFlagBuildExperienceModelPickerData and arg1.sendConfiguration ~= nil then sendConfiguration.capture(arg1.sendConfiguration.tier, arg1.sendConfiguration.experiment) else nil
                local model = if var1 ~= nil then var1.tier elseif FFlagBuildExperienceModelPickerData then arg1.model else nil

                if FFlagBuildExperienceModelPickerData then
                    assert(var1 == nil or arg1.model == nil or arg1.model == model, "conflicting model tiers")
                    local model2 = arg1.promptMeta and arg1.promptMeta._roblox and arg1.promptMeta._roblox.model
                    assert(model == nil or model2 == nil or model2 == model, "conflicting model tiers")
                    local experiment = arg1.promptMeta and arg1.promptMeta._roblox and arg1.promptMeta._roblox.experiment
                    assert(
                        var1 == nil or experiment == nil or sendConfiguration.sameExperiment(experiment, var1.experiment),
                        "conflicting experiments"
                    )
                end

                local var3 = tbl1.incrementAssistantTurnSequence()

                local getTurnHandle, var5 = Signals.createSignal(nil)
                local getSetupError, var7 = Signals.createSignal(nil)

                local bool1 = false
                local bool2 = false
                local bool3 = false
                local bool4 = false
                local bool5 = false
                local var8 = nil
                local var9 = nil
                local effect = nil

                local function fireCompleted(arg2)
                    if bool2 or var3 ~= tbl1.getAssistantTurnSequence() then
                        return
                    end

                    bool2 = true
                    tbl1.setActiveStop(nil)
                    if effect ~= nil then
                        effect()
                        effect = nil
                    end
                    if var9 ~= nil then
                        var9()
                        var9 = nil
                    end
                    if var8 ~= nil then
                        tbl1.noteTurnSequenceIds(var8)
                    end
                    if arg1.onCompleted ~= nil then
                        arg1.onCompleted(arg2)
                    end
                end

                local function start()
                    if bool1 then
                        return
                    end
                    bool1 = true

                    task.spawn(function()
                        if bool5 or FFlagBuildExperienceModelPickerData and arg1.isCancelled ~= nil and arg1.isCancelled() then
                            fireCompleted(nil)
                            return
                        end

                        if not FFlagBuildExperienceModelPickerData then
                            local var10, errorCode, var12 = tbl1.ensureInitialized()
                            if not var10 then
                                local var13 = var7
                                local tbl2 = {
                                    stage = "initialize",
                                    errorCode = errorCode,
                                    requestFailure = 0
                                }

                                if not FFlagBuildExperiencePromptFailureTelemetry then
                                    var12 = nil
                                end

                                tbl2.requestFailure = var12
                                var13(tbl2)

                                fireCompleted(nil)
                                return
                            end
                        end

                        local var10, var11

                        if FFlagBuildExperienceModelPickerData then
                            local ensureCasSession = tbl1.ensureCasSession
                            local var12 = model
                            local isCancelled = arg1.isCancelled
                            var10, var11 = ensureCasSession(var12, isCancelled, var1, true, if FFlagBuildExperienceChatOpenId then sendChatOpenId else nil)
                        else
                            var10, var11 = tbl1.ensureCasSession(model, nil, nil, nil, if FFlagBuildExperienceChatOpenId then sendChatOpenId else nil)
                        end

                        if var10 == nil then
                            if not FFlagBuildExperienceModelPickerData or var11 ~= nil then
                                var7(var11 or { stage = "session_new" })
                            end
                            fireCompleted(nil)
                            return
                        end

                        if bool5
                            or FFlagBuildExperienceModelPickerData
                                and (arg1.isCancelled ~= nil and arg1.isCancelled() or arg1.expectedSessionId ~= nil and arg1.expectedSessionId ~= var10)
                        then
                            fireCompleted(nil)
                            return
                        end

                        local var12, var13 = tbl1.sessionPrompt({ sessionId = var10, prompt = arg1.prompt, model = model, _meta = arg1.promptMeta }, var1)
                        var8 = var12
                        var5(var12)
                        if bool5 then
                            var12.cancel()
                        end

                        var9 = tbl1.startPollingTurnFromHistory(var10, var12, {
                            rtnIdleFallbackSeconds = arg1.rtnIdleFallbackSeconds,
                            rtnSequenceGapFallbackSeconds = arg1.rtnSequenceGapFallbackSeconds,
                            pollMinIntervalSeconds = arg1.pollMinIntervalSeconds,
                            pollMaxIntervalSeconds = arg1.pollMaxIntervalSeconds,
                            afterSequenceId = tbl1.getLatestObservedHistorySequenceId(),
                            onDroppedChatMessage = arg1.onDroppedChatMessage
                        })

                        effect = Signals.createEffect(function(arg2)
                            local var14 = var12.state(arg2)
                            if FFlagBuildExperienceModelPickerData
                                and var13 ~= nil
                                and (var14.status == "streaming"
                                    or var14.status == "succeeded"
                                    or FFlagBuildExperienceLibrary and var12.isAccepted(arg2) and not var14.isDone)
                            then
                                var13()
                                var13 = nil
                            end

                            if FFlagBuildExperienceLibrary and arg1.onAccepted ~= nil and not bool4 then
                                local bool6 = var14.status == "streaming" or var14.status == "succeeded"
                                local var15 = var12.isAccepted(arg2) and not var14.isDone
                                if bool6 or var15 then
                                    bool4 = true
                                    arg1.onAccepted()
                                end
                            end

                            if arg1.onReceived ~= nil and not bool3 and (var14.status == "streaming" or var14.status == "succeeded") then
                                bool3 = true
                                arg1.onReceived(var12.getTurnId())
                            end
                            if var14.isDone then
                                fireCompleted(var12.state(false))
                            end
                        end)
                    end)
                end

                local function stop()
                    if bool2 then
                        return
                    end
                    bool5 = true
                    if var8 ~= nil then
                        var8.cancel()
                        return
                    end

                    if effect ~= nil then
                        effect()
                        effect = nil
                    end
                    if var9 ~= nil then
                        var9()
                        var9 = nil
                    end
                    fireCompleted(nil)
                end

                tbl1.setActiveStop(stop)

                return {
                    getTurnHandle = getTurnHandle,
                    getSetupError = getSetupError,
                    start = start,
                    stop = stop
                }
            end
        }
    end
}
