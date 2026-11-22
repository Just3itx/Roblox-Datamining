-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:31:00Z
-- Luau bytecode version: 14 | Luau type version: 3
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local MomentsCommon = require(MomentsCreationParent.MomentsCommon)

local _CreationFlowTypes = require(MomentsCreation.Types.CreationFlowTypes)

local trimTool = require(MomentsCreation.Tools.trimTool)
local musicTool = require(MomentsCreation.Tools.musicTool)
local textTool = require(MomentsCreation.Tools.textTool)
local generateTextTool = require(MomentsCreation.Tools.generateTextTool)
local stickerTool = require(MomentsCreation.Tools.stickerTool)
local voiceTool = require(MomentsCreation.Tools.voiceTool)

local GetFFlagMomentsStickerButton = MomentsCommon.Flags.GetFFlagMomentsStickerButton
local GetFFlagMomentsTTSAudioOverlay = require(MomentsCreation.Flags.GetFFlagMomentsTTSAudioOverlay)

local tbl1 = {
    trimTool,
    musicTool,
    textTool,
    generateTextTool
}

if GetFFlagMomentsStickerButton() then
    table.insert(tbl1, stickerTool)
end

if GetFFlagMomentsTTSAudioOverlay and game:GetEngineFeature("TextToSpeechPlatformPreview") then
    table.insert(tbl1, voiceTool)
end

return tbl1
