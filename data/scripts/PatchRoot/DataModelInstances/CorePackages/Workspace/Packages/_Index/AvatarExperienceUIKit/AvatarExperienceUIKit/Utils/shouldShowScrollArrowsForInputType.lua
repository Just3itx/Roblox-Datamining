-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:11:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceUIKitParent = script:FindFirstAncestor("AvatarExperienceUIKit").Parent
local Responsive = require(AvatarExperienceUIKitParent.Responsive)

local function shouldShowScrollArrowsForInputType(touch: string): boolean
    return touch ~= Responsive.Input.Touch
end

return shouldShowScrollArrowsForInputType
