-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:50:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local llama = require(AppChatParent.LuaSocialLibrariesDeps).llama
local RoduxAliases = require(AppChat.Http.RoduxAliases)

local function convertToNewAliasUpdatedActions(arg1)
    local result = {}
    for _, value in ipairs(arg1) do
        local str1 = tostring(value.targetUserId)
        local targetUserTag = value.targetUserTag
        table.insert(result, RoduxAliases.Actions.AliasUpdated(str1, targetUserTag))
    end

    return result
end

local tbl1 = {
    GetAliases_Success = function(arg1)
        return (convertToNewAliasUpdatedActions(arg1.responseBody))
    end,
    ReceivedAliases = function(arg1)
        return (convertToNewAliasUpdatedActions(arg1.aliases))
    end
}

local var1 = RoduxAliases.installReducer()

return function(arg1, arg2)
    local var2 = tbl1[arg2.type]
    local var3 = not var2 and { arg2 } or var2(arg2)
    return llama.List.reduce(var3, var1, arg1 or { byUserId = { ShowUserAlias = true } })
end
