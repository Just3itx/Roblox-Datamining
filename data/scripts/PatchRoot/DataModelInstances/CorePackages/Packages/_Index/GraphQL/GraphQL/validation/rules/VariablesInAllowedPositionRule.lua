-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:20:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local inspect = require(scriptParentParentParent.jsutils.inspect).inspect
local GraphQLError = require(scriptParentParentParent.error.GraphQLError).GraphQLError
local Kind = require(scriptParentParentParent.language.kinds).Kind
local isNonNullType = require(scriptParentParentParent.type.definition).isNonNullType
local utilities = scriptParentParentParent.utilities
local typeFromAST = require(utilities.typeFromAST).typeFromAST
local isTypeSubTypeOf = require(utilities.typeComparators).isTypeSubTypeOf

local module = {}

local allowedVariableUsage = nil

function module.VariablesInAllowedPositionRule(arg1)
    local tbl1 = {}

    return {
        OperationDefinition = {
            enter = function()
                tbl1 = {}
            end,
            leave = function(_, arg2)
                local recursiveVariableUsages = arg1:getRecursiveVariableUsages(arg2)

                for _, value in ipairs(recursiveVariableUsages) do
                    local node = value.node
                    local type = value.type
                    local defaultValue = value.defaultValue
                    local value2 = node.name.value
                    local var1 = tbl1[value2]

                    if not (var1 and type) then
                        continue
                    end

                    local schema = arg1:getSchema()
                    local var2 = typeFromAST(schema, var1.type)
                    if not var2 or allowedVariableUsage(schema, var2, var1.defaultValue, type, defaultValue) then
                        continue
                    end

                    local var3 = inspect(var2)
                    local var4 = inspect(type)

                    arg1:reportError(
                        GraphQLError.new(
                            ("Variable \"$%s\" of type \"%s\" used in position expecting type \"%s\"."):format(value2, var3, var4),
                            { var1, node }
                        )
                    )
                end
            end
        },
        VariableDefinition = function(_, arg2)
            tbl1[arg2.variable.name.value] = arg2
        end
    }
end

allowedVariableUsage = function(arg1, arg2, arg3, arg4, arg5)
    if not isNonNullType(arg4) or isNonNullType(arg2) then
        return isTypeSubTypeOf(arg1, arg2, arg4)
    end

    local bool1 = not (arg3 == nil) and arg3.kind ~= Kind.NULL

    if not bool1 and arg5 == nil then
        return false
    end
    local ofType = arg4.ofType
    return isTypeSubTypeOf(arg1, arg2, ofType)
end

return module
