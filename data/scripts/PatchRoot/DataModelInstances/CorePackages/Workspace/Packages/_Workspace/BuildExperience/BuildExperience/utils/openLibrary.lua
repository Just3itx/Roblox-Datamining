-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:11:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local React = require(BuildExperienceParent.React)
local FFlagBuildExperienceLibrary = require(BuildExperienceParent.SharedFlags).FFlagBuildExperienceLibrary
local ProgressLoading = require(BuildExperienceParent.ProgressLoading)
local launchExperience = require(BuildExperienceParent.BuildExperiencePlaytestLaunch.launchExperience)
local sendBuildExperienceEvent = require(BuildExperience.Telemetry.sendBuildExperienceEvent)

local PregameOverride = ProgressLoading.PregameOverride

local function renderPregameSkeleton(tbl1)
    local libraryPregameSkeleton = require(BuildExperience.Components.Library.LibraryPregameSkeleton)
    return React.createElement(libraryPregameSkeleton, tbl1)
end

local function openLibrary(placeId: number, str1: string?)
    sendBuildExperienceEvent(
        "LIBRARY_IMPRESSION",
        { placeId = placeId, conversationId = str1 },
        { phase = "requested", surface = "App" }
    )

    if FFlagBuildExperienceLibrary then
        PregameOverride.setPregameOverride({ placeId = placeId, render = renderPregameSkeleton })
    end
    launchExperience(placeId, "BuildLibrary", false, { sessionId = str1 })
end

return openLibrary
