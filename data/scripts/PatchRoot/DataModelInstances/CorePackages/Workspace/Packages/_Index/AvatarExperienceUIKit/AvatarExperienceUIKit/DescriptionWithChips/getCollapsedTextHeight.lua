-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:10:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceUIKitParent = script:FindFirstAncestor("AvatarExperienceUIKit").Parent
local _Foundation = require(AvatarExperienceUIKitParent.Foundation)

local function getCollapsedTextHeight(arg1, num1: number)
    local bodyLarge = arg1.Typography.BodyLarge
    return bodyLarge.FontSize + (num1 - 1) * bodyLarge.FontSize * bodyLarge.LineHeight
end

return getCollapsedTextHeight
