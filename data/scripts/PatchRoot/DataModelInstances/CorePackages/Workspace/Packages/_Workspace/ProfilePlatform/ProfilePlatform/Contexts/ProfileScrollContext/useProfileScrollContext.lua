-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:30:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatformParent = script:FindFirstAncestor("ProfilePlatform").Parent
local React = require(ProfilePlatformParent.React)

local ProfileScrollContext = require(script.Parent.ProfileScrollContext)

return function()
    return React.useContext(ProfileScrollContext)
end
