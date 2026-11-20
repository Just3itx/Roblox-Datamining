-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:00:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Number = require(script.Parent.Parent.Parent.LuauPolyfill).Number
local null = require(script.Parent.null)

local function deepContains(arg1, arg2)
    if typeof(arg1) ~= typeof(arg2) then
        return false, (("{1}: value of type '%s'\n{2}: value of type '%s'"):format(typeof(arg1), typeof(arg2)))
    end

    if Number.isNaN(arg1) and Number.isNaN(arg2) then
        return true
    end

    if arg1 == arg2 then
        return true
    end

    if arg1 == null or arg2 == null or typeof(arg1) ~= "table" then
        return false, string.format("{1} (%s) ~= {2} (%s)", tostring(arg1), tostring(arg2))
    end

    for k, value in pairs(arg2) do
        local var1, var2 = deepContains(arg1[k], value)
        if not var1 then
            return false, (var2:gsub("{1}", ("{1}[%s]"):format(tostring(k))):gsub("{2}", ("{2}[%s]"):format(tostring(k))))
        end
    end
    return true
end

return deepContains
