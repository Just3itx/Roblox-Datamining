-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:11:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local GraphQLError = require(scriptParentParentParent.error.GraphQLError).GraphQLError

local module = {}

function module.KnownFragmentNamesRule(arg1)
    return {
        FragmentSpread = function(_, arg2)
            local value = arg2.name.value
            if not arg1:getFragment(value) then
                arg1:reportError(GraphQLError.new(("Unknown fragment \"%s\"."):format(value), arg2.name))
            end
        end
    }
end

return module
