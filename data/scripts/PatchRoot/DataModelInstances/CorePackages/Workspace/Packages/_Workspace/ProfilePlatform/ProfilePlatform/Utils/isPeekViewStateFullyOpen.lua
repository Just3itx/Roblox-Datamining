-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:10:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatformParent = script:FindFirstAncestor("ProfilePlatform").Parent

local PeekViewState = require(ProfilePlatformParent.PeekView).PeekViewState

return function(arg1): boolean
    return arg1 == PeekViewState.Full or arg1 == PeekViewState.Extended
end
