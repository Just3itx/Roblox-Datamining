-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:50:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local GraphQLError = require(scriptParent.GraphQLError).GraphQLError

return {
    syntaxError = function(arg1, num1: number, str1: string)
        return GraphQLError.new("Syntax Error: " .. str1, nil, arg1, { num1 })
    end
}
