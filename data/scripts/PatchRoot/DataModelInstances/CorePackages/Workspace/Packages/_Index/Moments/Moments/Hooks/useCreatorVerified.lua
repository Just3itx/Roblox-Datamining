-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:20:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local React = require(MomentsParent.React)
local _Signals = require(MomentsParent.Signals)
local SignalsReact = require(MomentsParent.SignalsReact)
local UserProfile = require(MomentsParent.DataHydration.UserProfile)

local useSignalState = SignalsReact.useSignalState

return function(num1: number)
    local var1 = React.useMemo(function()
        return UserProfile.getAndFetchUserInfo(num1).info
    end, { num1 })

    local var2 = useSignalState(var1)

    return not (var2 == nil) and var2.hasVerifiedBadge
end
