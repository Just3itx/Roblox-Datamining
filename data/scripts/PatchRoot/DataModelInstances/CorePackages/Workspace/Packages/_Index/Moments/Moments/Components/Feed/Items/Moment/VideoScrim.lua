-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:21:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local Foundation = require(MomentsParent.Foundation)
local React = require(MomentsParent.React)
local SignalsReact = require(MomentsParent.SignalsReact)

local getColorStyleWithTransparency = require(Moments.Utils.getColorStyleWithTransparency)
local MomentContext = require(script.Parent.MomentContext)

local useTokens = Foundation.Hooks.useTokens
local useSignalState = SignalsReact.useSignalState

return React.memo(function(tbl1) -- name: VideoScrim
    local var1 = useTokens()
    local var2 = MomentContext.useMoment()
    local active = useSignalState(var2.store.getIsScrubbing)

    local backgroundTransparency = var2.animationRatio:map(function(num1: number)
        return getColorStyleWithTransparency(var1.Color.Common.Scrim, 1 - num1).Transparency or 0
    end)

    return React.createElement("Frame", {
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = var1.Color.Common.Scrim.Color3,
        BackgroundTransparency = backgroundTransparency,
        BorderSizePixel = 0,
        Active = active,
        ZIndex = tbl1.ZIndex
    })
end)
