-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T21:11:15Z
-- Luau bytecode version: 14 | Luau type version: 3
local UserRelationshipModals = script:FindFirstAncestor("UserRelationshipModals")
local UserRelationshipModalsParent = UserRelationshipModals.Parent

local React = require(UserRelationshipModalsParent.React)
local ReactRoblox = require(UserRelationshipModalsParent.ReactRoblox)

return {
    name = "UserRelationshipModals",
    storyRoots = { UserRelationshipModals.Stories },
    roact = React,
    reactRoblox = ReactRoblox
}
