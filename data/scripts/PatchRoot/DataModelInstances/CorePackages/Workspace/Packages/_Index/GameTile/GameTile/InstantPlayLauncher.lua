-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:31:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameTileParent = script:FindFirstAncestor("GameTile").Parent

local React = require(GameTileParent.React)
local useRoactService = require(GameTileParent.RobloxAppHooks).useRoactService
local RoactNetworking = require(GameTileParent.RoactServiceTags).RoactNetworking
local AppSessionService = require(GameTileParent.RoactServiceTags).AppSessionService

local GamePlayButton = require(GameTileParent.GamePlayButton)
local PlayButtonStates = GamePlayButton.PlayButtonStates
local usePlayButtonState = GamePlayButton.usePlayButtonState
local useOnPlayButtonCallback = GamePlayButton.useOnPlayButtonCallback

local RobloxAppSessionization = require(GameTileParent.RobloxAppSessionization)
local SetGamePlaySession = RobloxAppSessionization.SetGamePlaySession
local SessionType = RobloxAppSessionization.SessionType

local function InstantPlayLauncher(tbl1)
    local var1 = useRoactService(RoactNetworking)
    local var2 = useRoactService(AppSessionService)
    local var3 = usePlayButtonState(var1, tbl1.universeId, nil, true)
    local var4 = React.useRef(false)

    local var5 = React.useMemo(function()
        return {
            launchData = tbl1.launchData
        }
    end, { tbl1.launchData })

    local var6 = useOnPlayButtonCallback(
        tbl1.universeId,
        tbl1.referralSource,
        tbl1.eventContext,
        nil,
        tbl1.launchSource,
        var5,
        tbl1.placeId
    )

    React.useEffect(function()
        if var4.current or var3.playButtonState == PlayButtonStates.Loading then
            return
        end

        var4.current = true
        if var3.playButtonState == PlayButtonStates.Playable then
            SetGamePlaySession(var2, SessionType.StructuralIdentifier.GamePlayFromInstantPlay, true)
            var6(var3.playButtonState, tbl1.reportExperienceLaunched)
        else
            tbl1.openGameDetails()
        end

        tbl1.onLaunchAttemptCompleted()
    end, {
        var6,
        var3.playButtonState,
        var2,
        tbl1.openGameDetails,
        tbl1.onLaunchAttemptCompleted,
        tbl1.reportExperienceLaunched
    })

    return nil
end

return InstantPlayLauncher
