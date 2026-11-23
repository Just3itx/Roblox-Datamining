-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T14:00:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent

local _AvatarExperienceUIKit = require(AvatarExperienceCommonParent.AvatarExperienceUIKit)

local function shouldRenderIndicatorStack(tbl1, tbl2): boolean
    return tbl1 ~= nil or tbl2 ~= nil
end

return shouldRenderIndicatorStack
