-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:10:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local devAssert = require(scriptParentParent.jsutils.devAssert).devAssert
local GraphQLError = require(scriptParentParent.error.GraphQLError).GraphQLError

local isValidNameError = nil

local function assertValidName(str1: string): string
    local var1 = isValidNameError(str1)
    if var1 then
        error(var1)
    end
    return str1
end

isValidNameError = function(str1: string)
    devAssert(type(str1) == "string", "Expected name to be a string.")
    if string.len(str1) > 1 and str1:sub(1, 1) == "_" and str1:sub(2, 2) == "_" then
        return GraphQLError.new("Name \"" .. str1 .. "\" must not begin with \"__\", which is reserved by GraphQL introspection.")
    end

    local var1, var2 = string.find(str1, "[_%a][_%a%d]*")

    if var1 ~= 1 or string.len(str1) ~= var2 then
        return GraphQLError.new("Names must match [_%a][_%a%d]* but \"" .. str1 .. "\" does not.")
    end

    return nil
end

return { assertValidName = assertValidName, isValidNameError = isValidNameError }
