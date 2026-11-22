-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:21:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local React = require(MomentsCreationParent.React)
local Signals = require(MomentsCreationParent.Signals)

local GetCreationFlowStore = require(MomentsCreation.Stores.GetCreationFlowStore)
local _CreationFlowTypes = require(MomentsCreation.Types.CreationFlowTypes)

local function useRestoredVoiceoverCheck(arg1)
    local creationFlowStore = GetCreationFlowStore(false)
    local ttsAudio = arg1.ttsAudio

    React.useEffect(function()
        if ttsAudio == nil then
            return
        end

        return Signals.createEffect(function(arg2)
            local pendingRestoredVoice = creationFlowStore.getPendingRestoredVoice(arg2)
            if pendingRestoredVoice == nil then
                return
            end

            local voice = creationFlowStore.getEditsMap(arg2).voice
            if voice == nil or voice.text ~= pendingRestoredVoice.text or voice.voiceId ~= pendingRestoredVoice.voiceId then
                creationFlowStore.setPendingRestoredVoice(nil)
                return
            end

            local state = ttsAudio.getState(arg2)
            if state == "ready" or state == "playing" then
                if ttsAudio.getLoadedText(arg2) == pendingRestoredVoice.text
                    and ttsAudio.getLoadedVoiceId(arg2) == pendingRestoredVoice.voiceId
                then
                    creationFlowStore.setPendingRestoredVoice(nil)
                end

                return
            end
            if state ~= "error" then
                return
            end
            local activeTool = arg1.getActiveTool(arg2)
            if activeTool ~= nil and activeTool.kind == "voice" then
                return
            end
            creationFlowStore.setPendingRestoredVoice(nil)
            creationFlowStore.setCommittedEdit("voice", nil)

            ttsAudio.reset()
        end)
    end, { creationFlowStore, arg1, ttsAudio })
end

return useRestoredVoiceoverCheck
