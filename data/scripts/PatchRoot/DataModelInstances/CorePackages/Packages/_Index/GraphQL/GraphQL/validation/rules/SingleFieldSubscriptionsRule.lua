-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:20:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local Array = require(scriptParentParentParentParent.LuauPolyfill).Array

local GraphQLError = require(scriptParentParentParent.error.GraphQLError).GraphQLError

local module = {}

function module.SingleFieldSubscriptionsRule(arg1)
    return {
        OperationDefinition = function(_, arg2)
            if arg2.operation == "subscription" and #arg2.selectionSet.selections ~= 1 then
                arg1:reportError(
                    GraphQLError.new(
                        arg2.name and ("Subscription \"%s\" must select only one top level field."):format(arg2.name.value)
                            or "Anonymous Subscription must select only one top level field.",
                        Array.slice(arg2.selectionSet.selections, 2)
                    )
                )
            end
        end
    }
end

return module
