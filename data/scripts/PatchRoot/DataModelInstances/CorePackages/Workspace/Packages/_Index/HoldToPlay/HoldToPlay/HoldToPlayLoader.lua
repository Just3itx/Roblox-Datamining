-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T00:00:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HoldToPlayParent = script:FindFirstAncestor("HoldToPlay").Parent

local React = require(HoldToPlayParent.React)
local useRoactService = require(HoldToPlayParent.RobloxAppHooks).useRoactService
local RoactServiceTags = require(HoldToPlayParent.RoactServiceTags)
local RoactNetworking = RoactServiceTags.RoactNetworking
local AppSessionService = RoactServiceTags.AppSessionService

local GamePlayButton = require(HoldToPlayParent.GamePlayButton)
local useOnPlayButtonCallback = GamePlayButton.useOnPlayButtonCallback
local usePlayButtonState = GamePlayButton.usePlayButtonState
local PlayButtonStates = GamePlayButton.PlayButtonStates

local RobloxAppSessionization = require(HoldToPlayParent.RobloxAppSessionization)
local SetGamePlaySession = RobloxAppSessionization.SetGamePlaySession
local SessionType = RobloxAppSessionization.SessionType

local HoldToPlayLauncher = require(HoldToPlayParent.ExperienceAnalytics).Constants.Context.HoldToPlayLauncher

local function HoldToPlayLoader(tbl1)
    local var1 = useRoactService(RoactNetworking)
    local var2 = useRoactService(AppSessionService)
    local var3 = usePlayButtonState(var1, tbl1.universeId)
    local var4 = useOnPlayButtonCallback(tbl1.universeId, nil, HoldToPlayLauncher, nil, nil)

    React.useEffect(function()
        local playButtonState = var3.playButtonState
        if not tbl1.shouldAttemptLaunch then
            return
        end

        SetGamePlaySession(var2, SessionType.StructuralIdentifier.GamePlayFromHoldToPlay, true)
        var4(playButtonState, tbl1.reportExperienceLaunched)
        if tbl1.onLaunched and playButtonState == PlayButtonStates.Playable then
            tbl1.onLaunched()
        end
    end, {
        tbl1.shouldAttemptLaunch,
        tbl1.onLaunched,
        var3.playButtonState,
        var2,
        tbl1.reportExperienceLaunched,
        var4
    })

    return nil
end

return HoldToPlayLoader
