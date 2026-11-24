-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:01:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent

local FFlagExpChatStickyTabs = require(ExpChatParent.SharedFlags).FFlagExpChatStickyTabs
local FFlagExpChatGlobalTabDefault = require(ExpChat.Flags.FFlagExpChatGlobalTabDefault)

local function isUserSelectedTabTracked()
    return FFlagExpChatStickyTabs or FFlagExpChatGlobalTabDefault
end

return isUserSelectedTabTracked
