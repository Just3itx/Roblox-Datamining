-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:31:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatformParent = script:FindFirstAncestor("ProfilePlatform").Parent
local ProfileWrapperContext = require(script.Parent.ProfileWrapperContext)
local React = require(ProfilePlatformParent.React)

return function()
    return React.useContext(ProfileWrapperContext)
end
