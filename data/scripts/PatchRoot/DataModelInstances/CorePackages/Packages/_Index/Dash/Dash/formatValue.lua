-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:30:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent

local function formatValue(arg1, str1: string?)
    local str2 = str1 or ""

    local var1, var2 = str2:find("[A-Za-z#?]+")
    if not var1 then
        local var3

        if type(arg1) == "number" then
            local _, num1 = math.modf(arg1)
            var3 = if num1 == 0 then "d" else "f"
        else
            var3 = "s"
        end

        return ("%" .. str2 .. var3):format(tostring(arg1))
    end

    local str3 = str2:sub(var1, var2)
    local str4 = "%" .. str2:sub(1, var1 - 1) .. str2:sub(var2 + 1) .. "s"

    local pretty = require(scriptParent.pretty)
    if str3 == "#?" then
        return str4:format(pretty(arg1, { multiline = true }))
    elseif str3 == "?" then
        return str4:format(pretty(arg1))
    end
    return ("%" .. str2):format(arg1)
end

return formatValue
