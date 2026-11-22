-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:31:03Z
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
local MusicOverlay = require(MomentsCreation.Components.MusicOverlay)
local MusicPickerV2Container = require(MomentsCreation.Components.MusicPickerV2Container)
local FFlagMomentsCreationMusicPickerV2 = require(MomentsCreation.Flags.FFlagMomentsCreationMusicPickerV2)
local FFlagMomentsCreateAvatarPosts = require(MomentsCreationParent.SharedFlags).FFlagMomentsCreateAvatarPosts

local EventNames = MomentsCommon.Analytics.EventNames

return {
    kind = "music",
    presentation = "Overlay",
    step = CreationFlowState.Music,
    zIndex = 2,
    cta = {
        icon = BuilderIcons.Icon.MusicNote,
        localizationKey = "Feature.Moments.Action.AddMusic",
        analyticsEvent = EventNames.EditingFlowMusicButtonPressed,
        commitAnalyticsEvent = EventNames.EditingFlowMusicDoneButtonPressed,
        cancelAnalyticsEvent = EventNames.EditingFlowMusicBackButtonPressed,
        order = 2
    },
    supportedCaptureTypes = { Enum.CaptureType.Video, Enum.CaptureType.Screenshot },
    supportedMomentTypes = FFlagMomentsCreateAvatarPosts and { MomentType.Avatar } or nil,
    createSession = function()
        return createEditSession()
    end,
    renderEditor = function(controller)
        if FFlagMomentsCreationMusicPickerV2 then
            return React.createElement(MusicPickerV2Container, { controller = controller })
        end
        return React.createElement(MusicOverlay, { controller = controller })
    end,
    toEdits = function(music)
        return { music = music }
    end
}
