-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:50:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local scriptParentParentParent = scriptParentParent.Parent
local Array = require(scriptParentParentParent.LuauPolyfill).Array

local null = require(scriptParentParent.luaUtils.null)
local isNillish = require(scriptParentParent.luaUtils.isNillish).isNillish

local _ObjMap = require(scriptParentParent.jsutils.ObjMap)

local keyMap = require(scriptParentParent.jsutils.keyMap).keyMap
local inspect = require(scriptParentParent.jsutils.inspect).inspect
local printPathArray = require(scriptParentParent.jsutils.printPathArray).printPathArray

local GraphQLError = require(scriptParentParent.error.GraphQLError).GraphQLError

local language = scriptParentParent.language
local _ast = require(language.ast)

local Kind = require(language.kinds).Kind
local print = require(language.printer).print

local type = scriptParentParent.type
local _schema = require(type.schema)

local _definition = require(type.definition)

local _directives = require(type.directives)

local definition = require(scriptParentParent.type.definition)
local isInputType = definition.isInputType
local isNonNullType = definition.isNonNullType

local typeFromAST = require(scriptParentParent.utilities.typeFromAST).typeFromAST
local valueFromAST = require(scriptParentParent.utilities.valueFromAST).valueFromAST
local coerceInputValue = require(scriptParentParent.utilities.coerceInputValue).coerceInputValue

local coerceVariableValues = nil

local hasOwnProperty = nil

local function getVariableValues(arg1, arg2, tbl1, tbl2)
    local errors = {}
    local maxErrors = if tbl2 ~= nil then tbl2.maxErrors else nil

    local success, result = pcall(coerceVariableValues, arg1, arg2, tbl1, function(arg3)
        if maxErrors ~= nil and #errors >= maxErrors then
            error(GraphQLError.new("Too many errors processing variables, error limit reached. Execution aborted."))
        end

        table.insert(errors, arg3)
    end)

    if not success then
        table.insert(errors, result)
    end

    return if #errors == 0 then { coerced = result } else { errors = errors }
end

coerceVariableValues = function(arg1, arg2, tbl1, callback: (...any) -> (...any))
    local result = ({})
    for _, value in ipairs(arg2) do
        local value2 = value.variable.name.value
        local var1 = typeFromAST(arg1, value.type)
        if not isInputType(var1) then
            local var2 = print(value.type)
            callback(
                GraphQLError.new(
                    ("Variable \"$%s\" expected value of type \"%s\" which cannot be used as an input type."):format(value2, var2),
                    value.type
                )
            )
        elseif hasOwnProperty(tbl1, value2) then
            local var2 = tbl1[value2]
            if var2 == null and isNonNullType(var1) then
                local var3 = inspect(var1)
                callback(GraphQLError.new(("Variable \"$%s\" of non-null type \"%s\" must not be null."):format(value2, var3), value))
            else
                result[value2] = coerceInputValue(var2, var1, function(arg3, arg4, arg5)
                    local var3 = ("Variable \"$%s\" got invalid value "):format(value2) .. inspect(arg4)
                    if #arg3 > 0 then
                        var3 ..= (" at \"%s%s\""):format(value2, printPathArray(arg3))
                    end
                    callback(GraphQLError.new(var3 .. "; " .. arg5.message, value, nil, nil, nil, arg5.originalError))
                end)
            end
        elseif value.defaultValue then
            result[value2] = valueFromAST(value.defaultValue, var1)
        elseif isNonNullType(var1) then
            local var2 = inspect(var1)
            callback(GraphQLError.new(("Variable \"$%s\" of required type \"%s\" was not provided."):format(value2, var2), value))
        end
    end

    return result
end

local function getArgumentValues(arg1, arg2, arg3)
    local argumentValues = ({})

    local var1 = not arg2.arguments and {} or arg2.arguments
    local var2 = keyMap(var1, function(arg4)
        return arg4.name.value
    end)

    for _, arg in ipairs(arg1.args) do
        local name = arg.name
        local type2 = arg.type

        local var3 = var2[name]

        if var3 then
            local value = var3.value
            local bool1 = value.kind == Kind.NULL

            if value.kind == Kind.VARIABLE then
                local value2 = value.name.value
                if arg3 == nil or not hasOwnProperty(arg3, value2) then
                    if arg.defaultValue == nil then
                        if not isNonNullType(type2) then
                            continue
                        end

                        error(
                            GraphQLError.new(
                                ("Argument \"%s\" of required type \"%s\" "):format(name, inspect(type2)) .. ("was provided the variable \"$%s\" which was not provided a runtime value."):format(value2),
                                value
                            )
                        )
                        continue
                    else
                        argumentValues[name] = arg.defaultValue
                        continue
                    end
                end

                bool1 = isNillish(arg3[value2])
            end

            if bool1 and isNonNullType(type2) then
                error(
                    GraphQLError.new(
                        ("Argument \"%s\" of non-null type \"%s\" "):format(name, inspect(type2)) .. "must not be null.",
                        value
                    )
                )
            end

            local var4 = valueFromAST(value, type2, arg3)
            if var4 == nil then
                error(GraphQLError.new(("Argument \"%s\" has invalid value %s."):format(name, print(value)), value))
            end

            argumentValues[name] = var4
        elseif arg.defaultValue == nil then
            if not isNonNullType(type2) then
                continue
            end

            error(
                GraphQLError.new(("Argument \"%s\" of required type \"%s\" "):format(name, inspect(type2)) .. "was not provided.", arg2)
            )
        else
            argumentValues[name] = arg.defaultValue
        end
    end

    return argumentValues
end

local function getDirectiveValues(arg1, tbl1, arg2)
    local var1 = if tbl1.directives then Array.find(tbl1.directives, function(arg3): boolean
        return arg3.name.value == arg1.name
    end) else nil

    if var1 then
        return getArgumentValues(arg1, var1, arg2)
    end

    return nil
end

hasOwnProperty = function(arg1, str1: string): boolean
    return arg1[str1] ~= nil
end

return {
    getVariableValues = getVariableValues,
    getArgumentValues = getArgumentValues,
    getDirectiveValues = getDirectiveValues
}
