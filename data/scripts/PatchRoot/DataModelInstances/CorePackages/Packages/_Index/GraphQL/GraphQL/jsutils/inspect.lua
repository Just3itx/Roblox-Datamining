-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:50:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local scriptParentParentParent = scriptParent.Parent.Parent
local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Object = LuauPolyfill.Object

local null = require(scriptParentParent.luaUtils.null)

local formatValue = nil
local formatObjectValue = nil
local formatArray = nil
local formatObject = nil
local getObjectTag = nil

local function inspect(arg1)
    return formatValue(arg1, {})
end

formatValue = function(input, arg1)
    local str1 = typeof(input)
    if str1 == "string" then
        return HttpService:JSONEncode(input)
    elseif str1 == "number" then
        if input ~= input then
            return "NaN"
        elseif input == math.huge then
            return "Infinity"
        elseif input == -math.huge then
            return "-Infinity"
        end
        return tostring(input)
    elseif str1 == "function" then
        return "[function]"
    elseif str1 == "table" then
        if input == null then
            return "null"
        end
        return formatObjectValue(input, arg1)
    else
        return tostring(input)
    end
end

formatObjectValue = function(arg1, tbl1: {any})
    if table.find(tbl1, arg1) ~= nil then
        return "[Circular]"
    end

    local tbl2 = { unpack(tbl1) }
    table.insert(tbl2, arg1)

    if typeof(arg1.toJSON) == "function" then
        local var1 = arg1:toJSON(arg1)

        if var1 ~= arg1 then
            if typeof(var1) == "string" then
                return var1
            end
            return formatValue(var1, tbl2)
        end
    elseif Array.isArray(arg1) then
        return formatArray(arg1, tbl2)
    end

    return formatObject(arg1, tbl2)
end

formatObject = function(arg1, arg2)
    local var1 = Object.keys(arg1)

    if #var1 == 0 then
        return "{}"
    end
    if #arg2 > 2 then
        return "[" .. getObjectTag(arg1) .. "]"
    end

    local tbl1 = ({})
    for i = 1, #var1 do
        local var2 = var1[i]
        tbl1[i] = var2 .. ": " .. formatValue(arg1[var2], arg2)
    end

    return "{ " .. table.concat(tbl1, ", ") .. " }"
end

formatArray = function(arg1, arg2): string
    local num1 = #arg1
    if num1 == 0 then
        return "[]"
    end
    if #arg2 > 2 then
        return "[Array]"
    end

    local num2 = math.min(10, num1)
    local num3 = num1 - num2
    local tbl1 = ({})

    for i = 1, num2 do
        tbl1[i] = formatValue(arg1[i], arg2)
    end

    if num3 == 1 then
        table.insert(tbl1, "... 1 more item")
    elseif num3 > 1 then
        table.insert(tbl1, ("... %d more items"):format(num3))
    end

    return "[" .. table.concat(tbl1, ", ") .. "]"
end

getObjectTag = function(_): string
    return "Object"
end

return { inspect = inspect }
