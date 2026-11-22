-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:30:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local MomentsCommon = require(MomentsCreationParent.MomentsCommon)

local _CreationFlowState = require(MomentsCreation.Enums.CreationFlowState)
local GetCreationFlowStore = require(MomentsCreation.Stores.GetCreationFlowStore)

local function resetCreationFlow(arg1)
    local creationFlowStore = GetCreationFlowStore(false)
    local tTsAudio = creationFlowStore.getTTSAudio(false)
    if tTsAudio ~= nil then
        tTsAudio.destroy()
        creationFlowStore.setTTSAudio(nil)
    end
    creationFlowStore.clearEdits(arg1)

    local funnelTypes = MomentsCommon.Analytics.FunnelEventNames.FunnelTypes
    local sessionManager = MomentsCommon.Analytics.SessionManager
    sessionManager.endSession(funnelTypes.CreationFlow)
    sessionManager.endSession(funnelTypes.MusicEnhancement)
    sessionManager.endSession(funnelTypes.TextOverlayEnhancement)
    sessionManager.endSession(funnelTypes.StickerOverlayEnhancement)
    sessionManager.endSession(funnelTypes.TrimEnhancement)
    sessionManager.endSession(funnelTypes.VoiceEnhancement)
end

return resetCreationFlow
