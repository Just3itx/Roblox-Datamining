-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:20:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local jsutils = scriptParentParentParent.jsutils
local inspect = require(jsutils.inspect).inspect
local GraphQLError = require(scriptParentParentParent.error.GraphQLError).GraphQLError
local definition = require(scriptParentParentParent.type.definition)
local getNamedType = definition.getNamedType
local isLeafType = definition.isLeafType

local module = {}

function module.ScalarLeafsRule(arg1)
    return {
        Field = function(_, arg2)
            local type = arg1:getType()
            local selectionSet = arg2.selectionSet
            if not type then
                return
            end

            if isLeafType(getNamedType(type)) then
                if selectionSet then
                    local value = arg2.name.value
                    local var1 = inspect(type)
                    arg1:reportError(
                        GraphQLError.new(
                            ("Field \"%s\" must not have a selection since type \"%s\" has no subfields."):format(value, var1),
                            selectionSet
                        )
                    )
                end
            elseif not selectionSet then
                local value = arg2.name.value
                local var1 = inspect(type)
                arg1:reportError(
                    GraphQLError.new(
                        ("Field \"%s\" of type \"%s\" must have a selection of subfields. Did you mean \"%s { ... }\"?"):format(
                            value,
                            var1,
                            value
                        ),
                        arg2
                    )
                )
            end
        end
    }
end

return module
