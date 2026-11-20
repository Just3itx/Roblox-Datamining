-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:50:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Boolean = LuauPolyfill.Boolean
local Error = LuauPolyfill.Error
local Object = LuauPolyfill.Object

local module = {}
local print = require(scriptParentParentParent.GraphQL).print

local _mergeTypedefs_types = require(script.Parent["merge-typedefs_types"])

local isSome = require(scriptParentParentParent.Utils).isSome

local deduplicateLists = nil

local function directiveAlreadyExists(arg1, arg2)
    return Boolean.toJSBoolean(Array.find(arg1, function(arg3): boolean
        return arg3.name.value == arg2.name.value
    end))
end

local function nameAlreadyExists(arg1, locations) -- Luacid: Inlined by compiler; 1 call site recovered
    return Array.some(locations, function(arg2): boolean
        return arg2.value == arg1.value
    end)
end

local function mergeArguments(arg1, arg2)
    local var1 = Array.concat({}, arg2)

    for _, value in arg1 do
        local index = Array.findIndex(var1, function(arg3): boolean
            return arg3.name.value == value.name.value
        end)

        if index > -1 then
            local var2 = var1[index]

            if var2.value.kind == "ListValue" then
                local values = var2.value.values
                local values2 = value.value.values
                var2.value.values = deduplicateLists(values, values2, function(arg3, arg4): boolean
                    local value2 = arg3.value
                    return not (Boolean.toJSBoolean(value2) and Array.some(arg4, function(arg5): boolean
                        return arg5.value == value2
                    end))
                end)
            else
                var2.value = value.value
            end
        else
            table.insert(var1, value)
        end
    end
    return var1
end

local function deduplicateDirectives(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return (Array.filter(Array.map(arg1, function(arg2, arg3, arg4)
        local index = Array.findIndex(arg4, function(arg5): boolean
            return arg5.name.value == arg2.name.value
        end)
        if index == arg3 then
            return arg2
        end

        local var1 = arg4[index]

        arg2.arguments = mergeArguments(arg2.arguments, var1.arguments)
        return nil
    end), isSome))
end

function module.mergeDirectives(arg1, arg2, arg3)
    local var1 = arg1 == nil and {} or arg1
    local var2 = arg2 == nil and {} or arg2

    local reverseDirectives = arg3 and arg3.reverseDirectives
    local var3 = if Boolean.toJSBoolean(reverseDirectives) then var1 else var2

    if Boolean.toJSBoolean(reverseDirectives) then
        var1 = var2
    end

    local var4 = deduplicateDirectives((Array.concat({}, var3)))

    for _, value in var1 do
        if Boolean.toJSBoolean(directiveAlreadyExists(var4, value)) then
            local index = Array.findIndex(var4, function(arg4): boolean
                return arg4.name.value == value.name.value
            end)

            local var5 = var4[index]
            var4[index].arguments = mergeArguments(
                not Boolean.toJSBoolean(value.arguments) and {} or value.arguments or {},
                not Boolean.toJSBoolean(var5.arguments) and {} or var5.arguments or {}
            )
        else
            table.insert(var4, value)
        end
    end
    return var4
end

local function validateInputs(arg1, arg2)
    local var1 = print(Object.assign({}, arg1, { description = Object.None }))
    local var2 = print(Object.assign({}, arg2, { description = Object.None }))

    local bool1 = var1:gsub("directive @w*d*", ""):gsub(" on .*$", "") == var2:gsub("directive @w*d*", ""):gsub(" on .*$", "")

    if not Boolean.toJSBoolean(bool1) then
        local error = error
        local new = Error.new

        local value = arg1.name.value
        error(
            new(
                ("Unable to merge GraphQL directive \"%s\". \nExisting directive:  \n\t%s \nReceived directive: \n\t%s"):format(
                    tostring(value),
                    tostring(var2),
                    tostring(var1)
                )
            )
        )
    end
end

function module.mergeDirective(arg1, arg2)
    if not arg2 then
        return arg1
    end

    validateInputs(arg1, arg2)
    return Object.assign({}, arg1, {
        locations = Array.concat({}, arg2.locations, Array.filter(arg1.locations, function(arg3): boolean
            return not nameAlreadyExists(arg3, arg2.locations)
        end))
    })
end

deduplicateLists = function(arg1, arg2, func1: (...any) -> (...any))
    return Array.concat(arg1, Array.filter(arg2, function(arg3)
        return func1(arg3, arg1)
    end))
end

return module
