-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:11:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceUIKitParent = script:FindFirstAncestor("AvatarExperienceUIKit").Parent
local _Foundation = require(AvatarExperienceUIKitParent.Foundation)

local function getFixedTabHeight(arg1)
    return arg1.Size.Size_800
end

return getFixedTabHeight
