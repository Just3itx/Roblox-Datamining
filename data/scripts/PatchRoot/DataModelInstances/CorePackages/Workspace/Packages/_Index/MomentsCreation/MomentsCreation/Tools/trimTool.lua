-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:31:07Z
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
local TrimmingView = require(MomentsCreation.Components.TrimmingView)

local EventNames = MomentsCommon.Analytics.EventNames

return {
    kind = "trim",
    presentation = "Step",
    step = CreationFlowState.Trimming,
    zIndex = 1,
    cta = {
        icon = BuilderIcons.Icon.ThreeBarsVerticalTrianglesHorizontal,
        localizationKey = "Feature.Moments.Action.TrimVideo",
        analyticsEvent = EventNames.EditingFlowTrimButtonPressed,
        commitAnalyticsEvent = EventNames.EditingFlowTrimDoneButtonPressed,
        cancelAnalyticsEvent = EventNames.EditingFlowTrimBackButtonPressed,
        order = 1
    },
    supportedCaptureTypes = { Enum.CaptureType.Video },
    createSession = function()
        return createEditSession()
    end,
    renderEditor = function(controller)
        return React.createElement(TrimmingView, { controller = controller, layoutOrder = 2 })
    end,
    toEdits = function(trim)
        return { trim = trim }
    end
}
