-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:01:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceControlBar = script:FindFirstAncestor("AvatarExperienceControlBar")

local AvatarExperienceControlBarParent = AvatarExperienceControlBar.Parent
local React = require(AvatarExperienceControlBarParent.React)

local useBaseControlBarProps = require(AvatarExperienceControlBar.useBaseControlBarProps)
local BaseControlBar = require(AvatarExperienceControlBar.BaseControlBar)

return React.memo(function(arg1) -- name: BaseControlBarContainer
    local var1 = useBaseControlBarProps(arg1)
    return React.createElement(BaseControlBar, var1)
end)
