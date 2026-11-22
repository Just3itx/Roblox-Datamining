-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:10:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local React = require(MomentsParent.React)

local AvatarActionBar = require(script.Parent.AvatarActionBar)
local useAvatarActionBarViewModel = require(script.Parent.useAvatarActionBarViewModel)

return React.memo(function(arg1) -- name: AvatarActionBarContainer
    local var1 = useAvatarActionBarViewModel(arg1)
    return React.createElement(AvatarActionBar, var1)
end)
