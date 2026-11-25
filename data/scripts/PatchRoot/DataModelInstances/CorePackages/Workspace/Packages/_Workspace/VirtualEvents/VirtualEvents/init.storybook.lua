-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:11:17Z
-- Luau bytecode version: 14 | Luau type version: 3
local VirtualEvents = script:FindFirstAncestor("VirtualEvents")

local RoactCompat = require(VirtualEvents.Parent.RoactCompat)

return {
    name = VirtualEvents.Name,
    roact = RoactCompat,
    storyRoots = { VirtualEvents }
}
