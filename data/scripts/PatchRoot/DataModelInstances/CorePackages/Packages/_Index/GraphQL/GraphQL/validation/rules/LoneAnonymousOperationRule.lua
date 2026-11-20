-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:11:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local Array = require(scriptParentParentParentParent.LuauPolyfill).Array

local GraphQLError = require(scriptParentParentParent.error.GraphQLError).GraphQLError
local language = scriptParentParentParent.language
local Kind = require(language.kinds).Kind

local module = {}

function module.LoneAnonymousOperationRule(arg1)
    local num1 = 0
    return {
        Document = function(_, arg2)
            num1 = #Array.filter(arg2.definitions, function(arg3): boolean
                return arg3.kind == Kind.OPERATION_DEFINITION
            end)
        end,
        OperationDefinition = function(_, arg2)
            if not arg2.name and num1 > 1 then
                arg1:reportError(GraphQLError.new("This anonymous operation must be the only defined operation.", arg2))
            end
        end
    }
end

return module
