-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:31:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local BuilderIcons = require(MomentsCreationParent.BuilderIcons)
local MomentsCommon = require(MomentsCreationParent.MomentsCommon)
local React = require(MomentsCreationParent.React)

local EventNames = MomentsCommon.Analytics.EventNames

local CreationFlowState = require(MomentsCreation.Enums.CreationFlowState)
local _CreationFlowTypes = require(MomentsCreation.Types.CreationFlowTypes)
local createEditSession = require(MomentsCreation.Stores.createEditSession)
local VoiceEditor = require(MomentsCreation.Components.Voice.VoiceEditor)
local VoicePreviewLayer = require(MomentsCreation.Components.Voice.VoicePreviewLayer)

return {
    kind = "voice",
    presentation = "Step",
    step = CreationFlowState.Voice,
    zIndex = 4,
    cta = {
        icon = BuilderIcons.Icon.FiveVerticalLinesWave,
        localizationKey = "Feature.Moments.Action.AddVoice",
        order = 4,
        analyticsEvent = EventNames.EditingFlowVoiceButtonPressed,
        commitAnalyticsEvent = EventNames.EditingFlowVoiceDoneButtonPressed,
        cancelAnalyticsEvent = EventNames.EditingFlowVoiceDeleteChangePressed,
        commitRequiresEdit = true
    },
    supportedCaptureTypes = { Enum.CaptureType.Video },
    createSession = function()
        return createEditSession()
    end,
    renderEditor = function(controller)
        return React.createElement(VoiceEditor, { controller = controller, layoutOrder = 2 })
    end,
    renderPreviewLayer = function(controller, ctx)
        return React.createElement(VoicePreviewLayer, { controller = controller, ctx = ctx, zIndex = 4 })
    end,
    toEdits = function(tts)
        return if tts == nil or tts.text == "" then {} else { tts = tts }
    end
}
