-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:21:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local Cryo = require(AppChatParent.Cryo)
local _AppChatNetworking = require(AppChatParent.AppChatNetworking)

local buildConversationMessageFromApi = require(script.Parent.buildConversationMessageFromApi)

local function buildValidMessages(str1: string, tbl1)
    return Cryo.List.filterMap(tbl1, function(arg1)
        if arg1 and arg1.id then
            return buildConversationMessageFromApi(arg1, str1)
        end
        return nil
    end)
end

return buildValidMessages
