-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:01:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Boolean = LuauPolyfill.Boolean
local Object = LuauPolyfill.Object

local module = {}
local GraphQL = require(scriptParentParent.GraphQL)
local valueFromAST = GraphQL.valueFromAST

local isNonNullType = GraphQL.isNonNullType
local Kind = GraphQL.Kind

local print = GraphQL.print

local createGraphQLError = require(script.Parent.errors).createGraphQLError
local inspect = require(script.Parent.inspect).inspect

function module.getArgumentValues(arg1, arg2, tbl1)
    local var1 = tbl1 == nil and {} or tbl1

    local var2 = Array.reduce(Object.entries(var1), function(tbl2, tbl3: {any})
        local var2, var3 = table.unpack(tbl3, 1, 2)
        return Object.assign({}, tbl2, { [tostring(var2)] = var3 })
    end, {})

    local argumentValues = {}
    local var3 = arg2.arguments == nil and {} or arg2.arguments

    local var4 = Array.reduce(var3, function(tbl2, arg3)
        local assign = Object.assign
        local tbl3 = {}
        local value = arg3.name.value
        tbl3[tostring(value)] = arg3
        return assign({}, tbl2, tbl3)
    end, {})

    for _, arg in arg1.args do
        local name = arg.name
        local type = arg.type
        local defaultValue = arg.defaultValue
        local var5 = var4[tostring(name)]
        if Boolean.toJSBoolean(var5) then
            local value = var5.value
            local bool1 = value.kind == Kind.NULL
            if value.kind == Kind.VARIABLE then
                local value2 = value.name.value
                if var1 == nil or var2[tostring(value2)] == nil then
                    if defaultValue == nil then
                        if not Boolean.toJSBoolean(isNonNullType(type)) then
                            continue
                        end

                        error(
                            createGraphQLError(
                                ("Argument \"%s\" of required type \"%s\" "):format(tostring(name), tostring(inspect(type))) .. ("was provided the variable \"$%s\" which was not provided a runtime value."):format(tostring(value2)),
                                {
                                    nodes = { value }
                                }
                            )
                        )
                        continue
                    else
                        argumentValues[tostring(name)] = defaultValue
                        continue
                    end
                end

                bool1 = var1[tostring(value2)] == nil
            end

            if bool1 and isNonNullType(type) then
                error(
                    createGraphQLError(
                        ("Argument \"%s\" of non-null type \"%s\" "):format(tostring(name), tostring(inspect(type))) .. "must not be null.",
                        {
                            nodes = { value }
                        }
                    )
                )
            end

            local var6 = valueFromAST(value, type, var1)
            if var6 == nil then
                error(
                    createGraphQLError(
                        ("Argument \"%s\" has invalid value %s."):format(tostring(name), tostring(print(value))),
                        {
                            nodes = { value }
                        }
                    )
                )
            end

            argumentValues[tostring(name)] = var6
        elseif defaultValue == nil then
            if not Boolean.toJSBoolean(isNonNullType(type)) then
                continue
            end

            error(
                createGraphQLError(
                    ("Argument \"%s\" of required type \"%s\" "):format(tostring(name), tostring(inspect(type))) .. "was not provided.",
                    {
                        nodes = { arg2 }
                    }
                )
            )
        else
            argumentValues[tostring(name)] = defaultValue
        end
    end

    return argumentValues
end

return module
