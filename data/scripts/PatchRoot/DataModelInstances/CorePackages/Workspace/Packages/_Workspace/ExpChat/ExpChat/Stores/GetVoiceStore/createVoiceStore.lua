-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:31:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent
local Signals = require(ExpChatParent.Signals)

local createSignal = Signals.createSignal
local createComputed = Signals.createComputed

local VOICE_STATE = require(ExpChatParent.VoiceChat).Constants.VOICE_STATE

local function createVoiceStore()
    local getVoiceParticipants, var2 = createSignal({})

    local tbl1 = ({})

    local function getKey(arg1): string -- Luacid: Inlined by compiler; 5 call sites recovered
        return tostring(arg1)
    end

    return {
        getOrCreateVoiceState = function(arg1)
            local key = getKey(arg1)

            if not tbl1[key] then
                tbl1[key] = createComputed(function(arg2)
                    return getVoiceParticipants(arg2)[key]
                end)
            end
            return tbl1[key]
        end,
        getVoiceParticipants = getVoiceParticipants,
        handleVoiceParticipantAdded = function(arg1)
            local key = getKey(arg1)

            var2(function(arg2)
                local var3 = table.clone(arg2)
                var3[key] = var3[key] or VOICE_STATE.HIDDEN

                return var3
            end)
        end,
        handleVoiceParticipantRemoved = function(arg1)
            local key = getKey(arg1)

            var2(function(arg2)
                if tbl1[key] then
                    tbl1[key] = nil
                end
                local var3 = table.clone(arg2)
                var3[key] = nil
                return var3
            end)
        end,
        handleVoiceParticipantsChanged = function(tbl2)
            var2(function(arg1)
                local var3 = table.clone(arg1)
                for value, value2 in tbl2 do
                    local inactive = VOICE_STATE.INACTIVE
                    if not value2.subscriptionCompleted then
                        inactive = VOICE_STATE.CONNECTING
                    elseif value2.isMutedLocally then
                        inactive = VOICE_STATE.LOCAL_MUTED
                    elseif value2.isMuted then
                        inactive = VOICE_STATE.MUTED
                    elseif value2.isSignalActive then
                        inactive = VOICE_STATE.TALKING
                    end

                    var3[getKey(value)] = inactive
                end
                return var3
            end)
        end,
        handleVoiceStateChanged = function(arg1, str1: string?)
            local key = getKey(arg1)

            var2(function(arg2)
                if not arg2[key] then
                    return arg2
                end

                local var3 = table.clone(arg2)
                var3[key] = str1
                return var3
            end)
        end
    }
end

return createVoiceStore
