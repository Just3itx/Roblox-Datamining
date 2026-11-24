-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T10:11:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatSharedParent = script:FindFirstAncestor("ExpChatShared").Parent
local Dictionary = require(ExpChatSharedParent.llama).Dictionary
local List = require(ExpChatSharedParent.llama).List

local function getAutocompletePlayersFromString(arg1, str1: string)
    local tbl1 = {}
    str1 = string.lower(str1)
    if string.sub(str1, 1, 1) == "@" then
        local str2 = string.sub(str1, 2)
        tbl1 = Dictionary.values(Dictionary.filter(arg1.byUsername, function(_, arg2): boolean
            return string.find(arg2, "^" .. str2) ~= nil
        end))
    else
        local var1 = Dictionary.filter(arg1.byDisplayName, function(_, arg2): boolean
            return string.find(arg2, "^" .. str1) ~= nil
        end)

        for _, value in pairs(var1) do
            for _, value2 in ipairs(value) do
                table.insert(tbl1, value2)
            end
        end
    end

    return List.map(tbl1, function(arg2)
        return arg1.byUserId[tostring(arg2)]
    end)
end

return getAutocompletePlayersFromString
