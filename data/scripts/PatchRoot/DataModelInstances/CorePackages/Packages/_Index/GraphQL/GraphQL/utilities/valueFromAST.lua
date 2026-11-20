-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:11:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local _ObjMap = require(scriptParentParent.jsutils.ObjMap)

local keyMap = require(scriptParentParent.jsutils.keyMap).keyMap
local inspect = require(scriptParentParent.jsutils.inspect).inspect
local invariant = require(scriptParentParent.jsutils.invariant).invariant

local _ast = require(scriptParentParent.language.ast)

local Kind = require(scriptParentParent.language.kinds).Kind

local definition = require(scriptParentParent.type.definition)

local isLeafType = definition.isLeafType
local isInputObjectType = definition.isInputObjectType
local isListType = definition.isListType
local isNonNullType = definition.isNonNullType

local null = require(scriptParentParent.luaUtils.null)

local isMissingVariable = nil

local function valueFromAST(arg1, arg2, arg3)
    if not arg1 then
        return
    end

    if arg1.kind == Kind.VARIABLE then
        local value = arg1.name.value
        if arg3 == nil or arg3[value] == nil then
            return
        end

        local var1 = arg3[value]

        if var1 ~= null or not isNonNullType(arg2) then
            return var1
        end

        return
    end
    if isNonNullType(arg2) then
        if arg1.kind ~= Kind.NULL then
            return valueFromAST(arg1, arg2.ofType, arg3)
        end

        return
    end

    if arg1.kind == Kind.NULL then
        return null
    elseif isListType(arg2) then
        local ofType = arg2.ofType
        if arg1.kind == Kind.LIST then
            local result = {}

            for _, value in ipairs(arg1.values) do
                if isMissingVariable(value, arg3) then
                    if isNonNullType(ofType) then
                        return
                    end
                    table.insert(result, null)
                else
                    local var1 = valueFromAST(value, ofType, arg3)
                    if var1 == nil then
                        return
                    end
                    table.insert(result, var1)
                end
            end
            return result
        end

        local var1 = valueFromAST(arg1, ofType, arg3)
        if var1 ~= nil then
            return { var1 }
        end
    elseif isInputObjectType(arg2) then
        if arg1.kind == Kind.OBJECT then
            local result = {}

            local var1 = keyMap(arg1.fields, function(arg4)
                return arg4.name.value
            end)

            for _, value in ipairs(arg2:getFields():values()) do
                local var2 = var1[value.name]
                if var2 and not isMissingVariable(var2.value, arg3) then
                    local var3 = valueFromAST(var2.value, value.type, arg3)
                    if var3 == nil then
                        return
                    end
                    result[value.name] = var3
                elseif value.defaultValue ~= nil then
                    result[value.name] = value.defaultValue
                elseif isNonNullType(value.type) then
                    return
                end
            end

            return result
        end
    elseif isLeafType(arg2) then
        local var1 = nil

        if not pcall(function()
            var1 = arg2:parseLiteral(arg1, arg3)
        end) then
            return
        end

        if var1 ~= nil then
            return var1
        end
    else
        invariant(false, "Unexpected input type: " .. inspect(arg2))
    end
end

isMissingVariable = function(arg1, arg2): boolean
    return arg1.kind == Kind.VARIABLE and (arg2 == nil or arg2[arg1.name.value] == nil)
end

return { valueFromAST = valueFromAST }
