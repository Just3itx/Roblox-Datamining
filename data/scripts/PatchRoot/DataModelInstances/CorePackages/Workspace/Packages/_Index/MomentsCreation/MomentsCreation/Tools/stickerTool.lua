-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:31:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local BuilderIcons = require(MomentsCreationParent.BuilderIcons)
local MomentsCommon = require(MomentsCreationParent.MomentsCommon)
local React = require(MomentsCreationParent.React)

local CreationFlowState = require(MomentsCreation.Enums.CreationFlowState)
local _CreationFlowTypes = require(MomentsCreation.Types.CreationFlowTypes)
local createEditSession = require(MomentsCreation.Stores.createEditSession)
local StickerOverlayControls = require(MomentsCreation.Components.StickerOverlay.StickerOverlayControls)
local StickerOverlayLayer = require(MomentsCreation.Components.StickerOverlay.StickerOverlayLayer)

local EventNames = MomentsCommon.Analytics.EventNames

return {
    kind = "sticker",
    presentation = "Step",
    step = CreationFlowState.StickerOverlay,
    zIndex = 3,
    cta = {
        icon = BuilderIcons.Icon.SquareFaceEmoji,
        localizationKey = "Feature.Moments.Action.AddSticker",
        analyticsEvent = EventNames.EditingFlowStickerOverlayButtonPressed,
        commitAnalyticsEvent = EventNames.EditingFlowStickerOverlayDoneButtonPressed,
        cancelAnalyticsEvent = EventNames.EditingFlowStickerOverlayBackButtonPressed,
        order = 4
    },
    supportedCaptureTypes = { Enum.CaptureType.Video },
    createSession = function()
        return createEditSession()
    end,
    renderEditor = function(controller)
        return React.createElement(StickerOverlayControls, { controller = controller, layoutOrder = 2 })
    end,
    renderPreviewLayer = function(controller, ctx)
        return React.createElement(StickerOverlayLayer, { controller = controller, ctx = ctx, zIndex = 3 })
    end,
    toEdits = function(stickerOverlays)
        local stickerOverlay = stickerOverlays and stickerOverlays[1]
        return if stickerOverlay == nil or stickerOverlay.stickerURI == nil or stickerOverlay.stickerURI == "" then {} else {
            stickerOverlays = stickerOverlays
        }
    end
}
