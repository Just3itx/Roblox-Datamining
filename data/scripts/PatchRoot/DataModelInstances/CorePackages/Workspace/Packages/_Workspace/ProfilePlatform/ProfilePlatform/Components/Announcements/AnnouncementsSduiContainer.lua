-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T04:41:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local React = require(ProfilePlatformParent.React)

local Enums = require(ProfilePlatform.Common.Enums)
local GroupPeekSduiSection = require(ProfilePlatform.Components.GroupPeekSduiSection)

return React.memo(function(tbl1) -- name: AnnouncementsSduiContainer
    return React.createElement(GroupPeekSduiSection, { layoutOrder = tbl1.layoutOrder, section = Enums.Components.Announcements })
end)
