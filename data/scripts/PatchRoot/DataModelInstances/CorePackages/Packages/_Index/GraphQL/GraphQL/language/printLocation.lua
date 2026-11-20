-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:00:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParent = scriptParent.Parent.Parent
local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array

local String = LuauPolyfill.String

local getLocation = require(scriptParent.location).getLocation

local whitespace = nil
local leftPad = nil
local printSourceLocation = nil
local printPrefixedLines = nil

local function printLocation(arg1)
    return printSourceLocation(arg1.source, getLocation(arg1.source, arg1.start))
end

printSourceLocation = function(arg1, arg2)
    local var1 = arg1.locationOffset.column - 1
    local var2 = whitespace(var1) .. arg1.body

    local var3 = arg2.line - 1 + 1
    local var4 = arg1.locationOffset.line - 1
    local var5 = arg2.line + var4

    local var6 = arg2.line == 1 and var1 or 0
    local var7 = arg2.column + var6
    local var8 = arg1.name .. ":" .. var5 .. ":" .. var7 .. "\n"

    local var9 = String.split(var2, { "\r\n", "\n", "\r" })
    local var10 = var9[var3]

    if not (string.len(var10) > 120) then
        return var8 .. printPrefixedLines(
            {
                { var5 - 1, var9[var3 - 1] },
                { var5, var10 },
                { "", whitespace(var7 - 1) .. "^" },
                { var5 + 1, var9[var3 + 1] }
            }
        )
    end

    local num1 = math.floor(var7 / 80) + 1
    local var11 = var7 % 80
    local tbl1 = {}
    for i = 1, string.len(var10), 80 do
        table.insert(tbl1, String.slice(var10, i, i + 80))
    end

    return var8 .. printPrefixedLines(
        Array.concat({{ tostring(var5), tbl1[1] }}, Array.map(Array.slice(tbl1, 2, num1 + 1), function(str1: string): {string}
            return { "", str1 }
        end), {{ " ", whitespace(var11 - 1) .. "^" }}, {{ "", tbl1[num1 + 1] }})
    )
end

printPrefixedLines = function(arg1)
    local var1 = Array.filter(arg1, function(arg2): boolean
        return arg2[2] ~= nil
    end)

    local map = Array.map

    local num1 = math.max(table.unpack(map(var1, function(arg2): number
        return string.len(arg2[1])
    end)))
    return Array.join(Array.map(var1, function(arg2)
        local var2 = arg2[1]
        local var3 = arg2[2]
        return leftPad(num1, var2) .. (if not var3 or var3 == "" then " |" else " | " .. var3 or " |")
    end), "\n")
end

whitespace = function(num1: number): string
    return string.rep(" ", num1)
end

leftPad = function(num1: number, str1: string): string
    return whitespace(num1 - string.len(str1)) .. str1
end

return { printSourceLocation = printSourceLocation, printLocation = printLocation }
