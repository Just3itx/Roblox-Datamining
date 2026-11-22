-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:21:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local React = require(MomentsParent.React)
local Signals = require(MomentsParent.Signals)
local SignalsReact = require(MomentsParent.SignalsReact)

local MomentContext = require(Moments.Components.Feed.Items.Moment.MomentContext)

local useSignalState = SignalsReact.useSignalState

local function useIsPlaying()
    local controller = MomentContext.useMoment().controller

    local var1 = React.useMemo(function()
        return Signals.createComputed(function(arg1)
            return not (controller == nil) and controller.getState(arg1).isPlaying
        end)
    end, { controller })

    return useSignalState(var1)
end

return useIsPlaying
