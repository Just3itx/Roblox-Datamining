-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T20:51:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GamePlayButton = script:FindFirstAncestor("GamePlayButton")

local OpenCentralOverlayForGameDetailsSquad = require(GamePlayButton.OpenCentralOverlayForGameDetailsSquad)
local PlayButtonStates = require(GamePlayButton.PlayButtonStates)

local GamePlayButtonParent = GamePlayButton.Parent
local React = require(GamePlayButtonParent.React)
local useDispatch = require(GamePlayButtonParent.RoactUtils).Hooks.RoactRodux.useDispatch

local GetFFlagIsSquadEnabled = require(GamePlayButtonParent.SharedFlags).GetFFlagIsSquadEnabled

return function<T>(arg1: T, playableWithParty: T, arg2: T, arg3: T)
    local var1 = useDispatch()

    return React.useCallback(function(arg4)
        if GetFFlagIsSquadEnabled() and playableWithParty == PlayButtonStates.PlayableWithParty then
            var1(OpenCentralOverlayForGameDetailsSquad(arg1, arg4.AbsolutePosition, arg4.AbsoluteSize, arg2, arg3))
        end
    end, {
        var1,
        arg1,
        arg2,
        playableWithParty,
        arg3
    })
end
