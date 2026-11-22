-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:50:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local React = require(MomentsCreationParent.React)
local _Signals = require(MomentsCreationParent.Signals)
local MomentsCommon = require(MomentsCreationParent.MomentsCommon)

local enableAudioPlaybackInApp = require(MomentsCreationParent.MediaPlayback).enableAudioPlaybackInApp

local feedPlaybackSuspension = MomentsCommon.Media.feedPlaybackSuspension

local _CreationFlowTypes = require(MomentsCreation.Types.CreationFlowTypes)

local function CreationMediaProvider(tbl1)
    React.useEffect(function()
        enableAudioPlaybackInApp()
    end, {})

    React.useEffect(function()
        feedPlaybackSuspension.setSuspended(true)
        return function()
            feedPlaybackSuspension.setSuspended(false)
        end
    end, {})

    return React.createElement(React.Fragment, nil, tbl1.children)
end

return CreationMediaProvider
