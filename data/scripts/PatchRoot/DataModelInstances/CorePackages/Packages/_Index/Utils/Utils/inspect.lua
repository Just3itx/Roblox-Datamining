-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:01:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Boolean = LuauPolyfill.Boolean
local Object = LuauPolyfill.Object
local instanceof = LuauPolyfill.instanceof

local Error = LuauPolyfill.Error

local module = {}

local formatValue = nil
local formatObjectValue = nil
local formatArray = nil
local isJSONable = nil
local formatObject = nil
local getObjectTag = nil

local GraphQLError = require(scriptParentParent.GraphQL).GraphQLError

local isAggregateError = require(script.Parent.AggregateError).isAggregateError

function module.inspect(arg1)
    return formatValue(arg1, {})
end

formatValue = function(arg1, arg2)
    local str1 = typeof(arg1)
    if str1 == "string" then
        return "\"" .. arg1 .. "\""
    elseif str1 == "function" then
        local var1 = debug.info(arg1, "n")
        if Boolean.toJSBoolean(var1) then
            return (("[function %s]"):format(var1))
        end

        return "[function]"
    elseif str1 == "table" then
        return formatObjectValue(arg1, arg2)
    else
        return tostring(arg1)
    end
end

local function formatError(arg1): string -- Luacid: Inlined by compiler; 1 call site recovered
    if instanceof(arg1, GraphQLError) then
        return tostring(arg1)
    end
    local str1 = tostring(arg1.name)
    local str2 = tostring(arg1.message)
    local stack = arg1.stack
    return ("%s: %s;\n %s"):format(str1, str2, tostring(stack))
end

formatObjectValue = function(arg1, arg2)
    if arg1 == nil then
        return "null"
    elseif instanceof(arg1, Error) then
        if isAggregateError(arg1) then
            return formatError(arg1) .. "\n" .. formatArray(arg1.errors, arg2)
        end

        return formatError(arg1)
    else
        if Boolean.toJSBoolean(Array.includes(arg2, arg1)) then
            return "[Circular]"
        end

        local var1 = Array.concat({}, arg2, { arg1 })

        if Boolean.toJSBoolean(isJSONable(arg1)) then
            local var2 = arg1:toJSON()

            if var2 ~= arg1 then
                if typeof(var2) == "string" then
                    return var2
                end

                return (formatValue(var2, var1))
            end
        elseif Boolean.toJSBoolean(Array.isArray(arg1)) then
            return formatArray(arg1, var1)
        end

        return formatObject(arg1, var1)
    end
end

isJSONable = function(arg1): boolean
    return typeof(arg1.toJSON) == "function"
end

formatObject = function(arg1, arg2): string
    local var1 = Object.entries(arg1)

    if #var1 == 0 then
        return "{}"
    end

    if #arg2 > 3 then
        return "[" .. tostring(getObjectTag(arg1)) .. "]"
    end
    local var2 = Array.map(var1, function(tbl1: {any}): string
        local var2, var3 = table.unpack(tbl1, 1, 2)
        return tostring(var2) .. ": " .. tostring(formatValue(var3, arg2))
    end)
    return "{ " .. tostring(Array.join(var2, ", ")) .. " }"
end

formatArray = function(arg1, arg2): string
    if #arg1 == 0 then
        return "[]"
    end

    if #arg2 > 3 then
        return "[Array]"
    end

    local num1 = #arg1
    local num2 = #arg1
    local num3 = 1
    local tbl1 = {}

    while num3 <= num1 do
        table.insert(tbl1, formatValue(arg1[num3], arg2))

        num3 += 1
    end

    if num2 == 1 then
        table.insert(tbl1, "... 1 more item")
    elseif num2 > 1 then
        local str1 = tostring(num2)
        table.insert(tbl1, ("... %s more items"):format(str1))
    end
    return "[" .. tostring(Array.join(tbl1, ", ")) .. "]"
end

getObjectTag = function(_): string
    return "Object"
end

return module
