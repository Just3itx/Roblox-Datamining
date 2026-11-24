-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:21:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local Signals = require(DataHydrationParent.Signals)
local _model = require(script.Parent.Parent.Types.model)
local FFlagBuildExperienceModelPickerData = require(DataHydrationParent.SharedFlags).FFlagBuildExperienceModelPickerData

return {
    createSessionScalarState = function(str1: string?)
        local var1, var2, var3, var4

        if FFlagBuildExperienceModelPickerData then
            var1, var2 = Signals.createSignal(nil)
            var3, var4 = Signals.createSignal(false)
        else
            var1 = nil
            var3 = nil
            var4 = nil
            var2 = nil
        end
        local getCasSessionId, setCasSessionId = Signals.createSignal(str1)
        local getHasLoadedHistory, setHasLoadedHistory = Signals.createSignal(false)
        local getNextHistoryPageToken, setNextHistoryPageToken = Signals.createSignal(nil)
        local getHistoryLoadInFlight, setHistoryLoadInFlight = Signals.createSignal(false)
        local getInitialized, setInitialized = Signals.createSignal(false)
        local getAssistantTurnSequence, var16 = Signals.createSignal(0)

        local getLatestObservedHistorySequenceId, var18 = Signals.createSignal(nil)

        local function setLatestObservedHistorySequenceId(num1: number?) -- Luacid: Inlined by compiler; 1 call site recovered
            var18(num1)
        end

        return {
            getModels = var1,
            hasObservedModels = var3,
            setHasObservedModels = var4,
            setModels = var2,
            getCasSessionId = getCasSessionId,
            setCasSessionId = setCasSessionId,
            getHasLoadedHistory = getHasLoadedHistory,
            setHasLoadedHistory = setHasLoadedHistory,
            markHistoryLoaded = function()
                setHasLoadedHistory(true)
            end,
            getNextHistoryPageToken = getNextHistoryPageToken,
            setNextHistoryPageToken = setNextHistoryPageToken,
            getHistoryLoadInFlight = getHistoryLoadInFlight,
            setHistoryLoadInFlight = setHistoryLoadInFlight,
            getInitialized = getInitialized,
            setInitialized = setInitialized,
            getAssistantTurnSequence = getAssistantTurnSequence,
            incrementAssistantTurnSequence = function()
                local var19 = getAssistantTurnSequence(false) + 1
                var16(var19)
                return var19
            end,
            getLatestObservedHistorySequenceId = getLatestObservedHistorySequenceId,
            setLatestObservedHistorySequenceId = setLatestObservedHistorySequenceId,
            noteHistorySequenceId = function(num1: number?)
                if num1 == nil then
                    return
                end
                local var19 = getLatestObservedHistorySequenceId(false)
                if var19 == nil or var19 < num1 then
                    setLatestObservedHistorySequenceId(num1)
                end
            end
        }
    end
}
