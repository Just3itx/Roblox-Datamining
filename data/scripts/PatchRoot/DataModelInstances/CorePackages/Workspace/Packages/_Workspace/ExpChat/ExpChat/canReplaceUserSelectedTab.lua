-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:41:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent

local FFlagExpChatStickyTabs = require(ExpChatParent.SharedFlags).FFlagExpChatStickyTabs

local function canReplaceUserSelectedTab(bool1: boolean?): boolean
    return not (FFlagExpChatStickyTabs and bool1)
end

return canReplaceUserSelectedTab
