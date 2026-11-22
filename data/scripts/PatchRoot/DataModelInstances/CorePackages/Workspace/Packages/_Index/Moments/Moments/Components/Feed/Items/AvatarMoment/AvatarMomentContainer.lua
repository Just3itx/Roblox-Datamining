-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:01:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent
local React = require(MomentsParent.React)

local AvatarMomentView = require(script.Parent.AvatarMomentView)
local useAvatarMomentViewModel = require(script.Parent.useAvatarMomentViewModel)

local function AvatarMomentContainer(arg1)
    local var1 = useAvatarMomentViewModel(arg1)
    return React.createElement(AvatarMomentView, var1)
end

return AvatarMomentContainer
