-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:31:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local BuilderIcons = require(MomentsCreationParent.BuilderIcons)
local MomentsCommon = require(MomentsCreationParent.MomentsCommon)

local _CreationFlowTypes = require(MomentsCreation.Types.CreationFlowTypes)
local DialogType = require(MomentsCreation.Enums.DialogType)
local GetFFlagMomentsTextGenTonePicker = require(MomentsCreation.Flags.GetFFlagMomentsTextGenTonePicker)
local GetFFlagMomentsGenerateTextInTextOverlay = require(MomentsCreation.Flags.GetFFlagMomentsGenerateTextInTextOverlay)

local EventNames = MomentsCommon.Analytics.EventNames
local GetFFlagEnableMomentTextGeneration = MomentsCommon.Flags.GetFFlagEnableMomentTextGeneration

return {
    kind = "generateText",
    presentation = "InstantAction",
    cta = {
        icon = BuilderIcons.Icon.TagSparkle,
        localizationKey = "Feature.Moments.Action.GenerateText",
        analyticsEvent = EventNames.EditingFlowGenerateTextButtonPressed,
        order = if GetFFlagEnableMomentTextGeneration() then 5 else 4
    },
    supportedCaptureTypes = { Enum.CaptureType.Video },
    isAvailable = function(arg1): boolean
        return not GetFFlagMomentsGenerateTextInTextOverlay() and arg1.canGenerateText == true
    end,
    apply = function(arg1)
        local isStudio = game:GetService("RunService"):IsStudio()
        local showTone = GetFFlagMomentsTextGenTonePicker() and (game:GetEngineFeature("CaptureServiceMomentTextTone") or isStudio)

        if not showTone then
            arg1.generateText()

            return
        end

        arg1.showModal({
            modalType = DialogType.GenerateTextOptions,
            modalProps = {
                showTone = showTone,
                onSelect = function(str1: string?)
                    arg1.dismissModal()
                    arg1.generateText(str1)
                end,
                onCancel = arg1.dismissModal
            }
        })
    end
}
