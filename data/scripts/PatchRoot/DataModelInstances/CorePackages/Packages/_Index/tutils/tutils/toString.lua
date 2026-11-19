-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T11:20:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local checkListConsistency = require(script.Parent.checkListConsistency)

local function recursiveToString(arg1, arg2)
    arg2 = arg2 or ""

    if type(arg1) ~= "table" then
        return tostring(arg1)
    end

    local str1 = ""
    if not checkListConsistency(arg1) then
        str1 ..= "-- WARNING: this table fails the list consistency test\n"
    end
    local str2 = str1 .. "{\n"
    for k, value in pairs(arg1) do
        if type(k) == "string" then
            str2 ..= "  " .. arg2 .. tostring(k) .. " = " .. recursiveToString(value, "  " .. arg2) .. ";\n"
        end
        if type(k) == "number" then
            str2 ..= "  " .. arg2 .. recursiveToString(value, "  " .. arg2) .. ",\n"
        end
    end
    return str2 .. arg2 .. "}"
end

return recursiveToString
