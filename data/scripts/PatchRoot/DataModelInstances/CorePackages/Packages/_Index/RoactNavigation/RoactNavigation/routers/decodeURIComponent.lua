-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:20:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local Array = require(scriptParentParentParent.LuauPolyfill).Array
local RegExp = require(scriptParentParentParent.RegExp)

local function stringMatch(arg1, arg2)
    local var1 = arg2:exec(arg1)
    local result = {}

    while var1 do
        local var2 = var1[1]
        table.insert(result, var2)
        var1 = arg2:exec((var1.input:sub(var1.index + var2:len())))
    end

    return result
end

local function TypeError<T>(arg1: T): T -- Luacid: unused: defined but never referenced
    return arg1
end

local var1 = RegExp("(%[a-fA-F0-9]{2})+", "i")

local function decodeURIComponent(arg1)
    local var2 = var1:exec(arg1)

    if var2 then
        local tbl1 = {}
        for value in var2[1]:gmatch("%%(%x%x)") do
            local var3 = tonumber(value, 16)
            if var3 >= 128 then
                error("malformed URI sequence")
            end
            table.insert(tbl1, var3)
        end

        arg1 = utf8.char(unpack(tbl1))
    end

    return arg1
end

local var2 = RegExp("%[a-fA-F0-9]{2}", "i")
local var3 = RegExp("(%[a-fA-F0-9]{2})+", "i")

local function decodeComponents(arg1, arg2)
    local success, result = pcall(decodeURIComponent, table.concat(arg1, ""))

    if success then
        return result
    end

    if #arg1 == 1 then
        return arg1
    end

    arg2 = arg2 or 1

    local var4 = Array.slice(arg1, 1, arg2 + 1)
    local var5 = Array.slice(arg1, arg2 + 1)

    return Array.concat(decodeComponents(var4), decodeComponents(var5))
end

local function decode(arg1)
    local success, result = pcall(decodeURIComponent, arg1)

    if success then
        return result
    end

    local tbl1 = stringMatch(arg1, var2)
    local num1 = 2

    while tbl1[num1] do
        arg1 = table.concat(decodeComponents(tbl1, num1), "")

        tbl1 = stringMatch(arg1, var2)
        num1 += 1
    end

    return arg1
end

local function escapePercent(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    return (arg1:gsub("%%", "%%%%"))
end

local function customDecodeURIComponent(arg1)
    local str1 = utf8.char(65533)
    local tbl1 = {
        ["%FE%FF"] = str1 .. str1,
        ["%FF%FE"] = str1 .. str1
    }

    local var4 = var3:exec(arg1)
    local tbl2 = { "%FE%FF", "%FF%FE" }

    while var4 do
        local var5 = var4[1]

        local success, result = xpcall(decodeURIComponent, function(_)
            local var6 = decode(var5)

            if var6 == var5 then
                return
            end

            if tbl1[var5] == nil then
                table.insert(tbl2, var5)
            end
            tbl1[var5] = var6
        end, var5)

        if success then
            if tbl1[var5] == nil then
                table.insert(tbl2, var5)
            end
            tbl1[var5] = result
        end

        local var6 = var4.input:sub(var4.index + var5:len())
        var4 = var3:exec(var6)
    end

    tbl1["%C2"] = str1
    table.insert(tbl2, "%C2")

    for _, value in tbl2 do
        arg1 = string.gsub(arg1, escapePercent(value), (escapePercent(tbl1[value])))
    end

    return arg1
end

local function decodeComponent(arg1)
    if type(arg1) ~= "string" then
        error("Expected `encodedURI` to be of type `string`, got `" .. typeof(arg1) .. "`")
    end

    arg1 = arg1:gsub("%+", " ")

    return (customDecodeURIComponent(arg1))
end

return decodeComponent
