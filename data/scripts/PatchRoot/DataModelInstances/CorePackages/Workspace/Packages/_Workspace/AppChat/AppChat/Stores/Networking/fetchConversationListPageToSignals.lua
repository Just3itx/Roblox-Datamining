-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:21:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Promise = require(AppChatParent.Promise)

local GetConversationPageDataHydration = require(AppChat.Stores.GetConversationPageDataHydration)

local function fetchConversationListPageToSignals(tbl1)
    local cursor = if tbl1 == nil then nil else tbl1.cursor
    GetConversationPageDataHydration.fetchPage(cursor)

    return Promise.resolve(nil)
end

return fetchConversationListPageToSignals
