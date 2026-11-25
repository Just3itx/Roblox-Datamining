-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:30:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatformParent = script:FindFirstAncestor("ProfilePlatform").Parent

local React = require(ProfilePlatformParent.React)
local HorizontalPageMargin = require(ProfilePlatformParent.UIBlox).App.Container.HorizontalPageMargin

local function SocialCountsRow(tbl1)
    return React.createElement(
        HorizontalPageMargin,
        {
            backgroundTransparency = 1,
            layoutOrder = tbl1.layoutOrder,
            useAutomaticSizing = true,
            size = tbl1.size
        },
        tbl1.children
    )
end
return SocialCountsRow
