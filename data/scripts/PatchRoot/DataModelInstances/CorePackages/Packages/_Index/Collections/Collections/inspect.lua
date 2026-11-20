-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:41:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent

local isArray = require(scriptParent.Array.isArray)
local _ES7Types = require(scriptParentParent.ES7Types)

local formatValue = nil
local formatObjectValue = nil
local formatArray = nil
local formatObject = nil
local getObjectTag = nil

local function inspect(arg1, tbl1)
    local var1 = tbl1 or { depth = 2 }
    local depth = var1.depth or 2
    var1.depth = if depth >= 0 then depth else 2
    return formatValue(arg1, {}, var1)
end

local function isIndexKey(arg1, num1: number): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return type(arg1) == "number" and arg1 <= num1 and arg1 >= 1 and math.floor(arg1) == arg1
end

local function getTableLength(tbl1: {any}): number -- Luacid: unused: defined but never referenced
    local num1 = 1
    local var1 = rawget(tbl1, num1)
    while var1 ~= nil do
        num1 += 1
        var1 = rawget(tbl1, num1)
    end
    return num1 - 1
end

local function sortKeysForPrinting(arg1, arg2): boolean
    local str1 = type(arg1)
    local str2 = type(arg2)

    return if str1 == str2 and (str1 == "number" or str1 == "string") then arg1 < arg2 else str1 < str2
end

local function rawpairs<T>(arg1: T) -- Luacid: unused: defined but never referenced
    return next, arg1, nil
end

local function getFragmentedKeys(tbl1: {any})
    local num1 = 1
    local var1 = rawget(tbl1, num1)
    local num2 = 0
    local tbl2 = ({})

    while var1 ~= nil do
        num1 += 1
        var1 = rawget(tbl1, num1)
    end
    local num3 = num1 - 1

    for k, _ in next, tbl1 do
        if not isIndexKey(k, num3) then
            num2 += 1
            tbl2[num2] = k
        end
    end
    table.sort(tbl2, sortKeysForPrinting)
    return tbl2, num2, num3
end

formatValue = function(input, arg1, tbl1)
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
        local str2 = "[function"
        local var1 = debug.info(input, "n")
        if var1 ~= nil and var1 ~= "" then
            str2 ..= " " .. var1
        end
        return str2 .. "]"
    elseif str1 == "table" then
        return formatObjectValue(input, arg1, tbl1)
    else
        return tostring(input)
    end
end

formatObjectValue = function(arg1, tbl1: {any}, tbl2)
    if table.find(tbl1, arg1) ~= nil then
        return "[Circular]"
    end

    local tbl3 = { unpack(tbl1) }
    table.insert(tbl3, arg1)

    if typeof(arg1.toJSON) == "function" then
        local var1 = arg1:toJSON(arg1)

        if var1 ~= arg1 then
            if typeof(var1) == "string" then
                return var1
            end
            return formatValue(var1, tbl3, tbl2)
        end
    elseif isArray(arg1) then
        return formatArray(arg1, tbl3, tbl2)
    end

    return formatObject(arg1, tbl3, tbl2)
end

formatObject = function(arg1, arg2, tbl1)
    local str1 = ""
    local var1 = getmetatable(arg1)
    if var1 and rawget(var1, "__tostring") then
        return tostring(arg1)
    end

    local tbl2, num1, num2 = getFragmentedKeys(arg1)

    if num2 == 0 and num1 == 0 then
        return str1 .. "{}"
    end
    if #arg2 > tbl1.depth then
        return str1 .. "[" .. getObjectTag(arg1) .. "]"
    end

    local tbl3 = {}
    for i = 1, num2 do
        table.insert(tbl3, (formatValue(arg1[i], arg2, tbl1)))
    end

    for i = 1, num1 do
        local var2 = tbl2[i]
        table.insert(tbl3, var2 .. ": " .. formatValue(arg1[var2], arg2, tbl1))
    end

    return str1 .. "{ " .. table.concat(tbl3, ", ") .. " }"
end

formatArray = function(arg1, arg2, tbl1): string
    local num1 = #arg1
    if num1 == 0 then
        return "[]"
    end
    if #arg2 > tbl1.depth then
        return "[Array]"
    end

    local num2 = math.min(10, num1)
    local num3 = num1 - num2
    local tbl2 = ({})

    for i = 1, num2 do
        tbl2[i] = formatValue(arg1[i], arg2, tbl1)
    end

    if num3 == 1 then
        table.insert(tbl2, "... 1 more item")
    elseif num3 > 1 then
        local str1 = tostring(num3)
        table.insert(tbl2, ("... %s more items"):format(str1))
    end

    return "[" .. table.concat(tbl2, ", ") .. "]"
end

getObjectTag = function(_): string
    return "Object"
end

return inspect
