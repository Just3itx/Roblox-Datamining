-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:11:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local GraphQLError = require(scriptParentParentParent.error.GraphQLError).GraphQLError
local language = scriptParentParentParent.language
local Kind = require(language.kinds).Kind
local isExecutableDefinitionNode = require(language.predicates).isExecutableDefinitionNode

local module = {}

function module.ExecutableDefinitionsRule(arg1)
    return {
        Document = function(_, arg2): boolean
            for _, definition in ipairs(arg2.definitions) do
                if not isExecutableDefinitionNode(definition) then
                    local var1 = if definition.kind == Kind.SCHEMA_DEFINITION or definition.kind == Kind.SCHEMA_EXTENSION then "schema" else "\"" .. definition.name.value .. "\""

                    arg1:reportError(GraphQLError.new(("The %s definition is not executable."):format(var1), definition))
                end
            end

            return false
        end
    }
end

return module
