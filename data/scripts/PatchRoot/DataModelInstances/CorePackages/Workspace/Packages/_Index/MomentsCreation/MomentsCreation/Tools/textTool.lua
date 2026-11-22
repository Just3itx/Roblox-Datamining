-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:31:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local BuilderIcons = require(MomentsCreationParent.BuilderIcons)
local MomentsCommon = require(MomentsCreationParent.MomentsCommon)
local React = require(MomentsCreationParent.React)

local CreationFlowState = require(MomentsCreation.Enums.CreationFlowState)
local MomentType = require(MomentsCreation.Enums.MomentType)
local _CreationFlowTypes = require(MomentsCreation.Types.CreationFlowTypes)
local createEditSession = require(MomentsCreation.Stores.createEditSession)
local TextOverlayControls = require(MomentsCreation.Components.TextOverlay.TextOverlayControls)
local TextOverlayLayer = require(MomentsCreation.Components.TextOverlay.TextOverlayLayer)
local FFlagMomentsTextOverlayOnPhotos = require(MomentsCreation.Flags.FFlagMomentsTextOverlayOnPhotos)
local FFlagMomentsCreateAvatarPosts = require(MomentsCreationParent.SharedFlags).FFlagMomentsCreateAvatarPosts

local EventNames = MomentsCommon.Analytics.EventNames

return {
    kind = "text",
    presentation = "Step",
    step = CreationFlowState.TextOverlay,
    zIndex = 3,
    cta = {
        icon = BuilderIcons.Icon.TextUppercaseALowercaseA,
        localizationKey = "Feature.Moments.Action.AddText",
        analyticsEvent = EventNames.EditingFlowTextOverlayButtonPressed,
        commitAnalyticsEvent = EventNames.EditingFlowTextOverlayDoneButtonPressed,
        cancelAnalyticsEvent = EventNames.EditingFlowTextOverlayBackButtonPressed,
        order = 3
    },
    supportedCaptureTypes = FFlagMomentsTextOverlayOnPhotos and { Enum.CaptureType.Video, Enum.CaptureType.Screenshot }
        or { Enum.CaptureType.Video },
    supportedMomentTypes = FFlagMomentsCreateAvatarPosts and { MomentType.Avatar } or nil,
    createSession = function()
        return createEditSession()
    end,
    renderEditor = function(controller)
        return React.createElement(TextOverlayControls, { controller = controller, layoutOrder = 2 })
    end,
    renderPreviewLayer = function(controller, ctx)
        return React.createElement(TextOverlayLayer, { controller = controller, ctx = ctx, zIndex = 3 })
    end,
    toEdits = function(textOverlays)
        local textOverlay = textOverlays and textOverlays[1]

        return if textOverlay == nil or textOverlay.text == "" then {} else {
            textOverlays = textOverlays
        }
    end
}
