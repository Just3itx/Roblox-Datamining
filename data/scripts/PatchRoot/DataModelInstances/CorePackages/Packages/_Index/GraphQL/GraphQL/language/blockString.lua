-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:00:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local String = LuauPolyfill.String

local getBlockStringIndentation = nil

local function dedentBlockStringValue(str1: string)
    local var1 = String.split(str1, { "\r\n", "\n", "\r" })

    local blockStringIndentation = getBlockStringIndentation(str1)

    if blockStringIndentation ~= 0 then
        for i = 2, #var1 do
            var1[i] = String.slice(var1[i], blockStringIndentation + 1)
        end
    end

    local num1 = 0

    while num1 < #var1 and isBlank(var1[num1 + 1]) do
        num1 += 1
    end

    local num2 = #var1
    while num1 < num2 and isBlank(var1[num2 - 1 + 1]) do
        num2 -= 1
    end

    return Array.join(Array.slice(var1, num1 + 1, num2 + 1), "\n")
end

function isBlank(str1: string)
    for i = 1, #str1 do
        local str2 = string.sub(str1, i, i)
        if str2 ~= " " and str2 ~= "\t" then
            return false
        end
    end

    return true
end

getBlockStringIndentation = function(str1: string)
    local num1 = string.len(str1)
    local num2 = 1
    local num3 = 0
    local bool1 = true
    local bool2 = true
    local var1 = nil

    while num2 <= num1 do
        local var2 = String.charCodeAt(str1, num2)
        if var2 == 13 and String.charCodeAt(str1, num2 + 1) == 10 then
            num2 += 1
        end

        if var2 == 10 then
            num3 = 0
            bool1 = true
            bool2 = false
        elseif var2 == 9 or var2 == 32 then
            num3 += 1
        else
            if bool1 and bool2 ~= true and (var1 == nil or num3 < var1) then
                var1 = num3
            end

            bool1 = false
        end

        num2 += 1
    end

    return var1 and var1 or 0
end

return {
    getBlockStringIndentation = getBlockStringIndentation,
    dedentBlockStringValue = dedentBlockStringValue,
    printBlockString = function(str1: string, str2: string?, bool1: boolean?)
        local str3 = str2 or ""
        if bool1 == nil then
            bool1 = false
        end

        local bool2 = string.find(str1, "\n") == nil
        local bool3 = string.sub(str1, 1, 1) == " " or string.sub(str1, 1, 1) == "\t"
        local bool4 = string.sub(str1, #str1, #str1) == "\""
        local bool5 = string.sub(str1, #str1, #str1) == "\\"
        local var1 = bool2 ~= true or bool4 or bool5 or bool1

        local str4 = ""

        if var1 and (bool2 and bool3) ~= true then
            str4 ..= "\n" .. str3
        end

        if str3 ~= "" then
            str1 = string.gsub(str1, "\n", "\n" .. str3) or str1
        end

        local var2 = str4 .. str1
        if var1 then
            var2 ..= "\n"
        end
        return "\"\"\"" .. string.gsub(var2, "\"\"\"", "\\\"\"\"") .. "\"\"\""
    end
}
