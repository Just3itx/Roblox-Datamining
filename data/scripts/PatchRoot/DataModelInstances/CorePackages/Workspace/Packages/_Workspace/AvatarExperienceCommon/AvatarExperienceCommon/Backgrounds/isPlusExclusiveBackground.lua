-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:10:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local getTemporaryPlusBackgroundIds = require(script.Parent.getTemporaryPlusBackgroundIds)

local function isPlusExclusiveBackground(arg1, bool1: boolean?): boolean
    if bool1 ~= nil then
        return bool1
    end
    local var1, var2 = getTemporaryPlusBackgroundIds()
    if var2 then
        return arg1 ~= nil
    end
    return not (arg1 == nil) and var1[tostring(arg1)] == true
end

return isPlusExclusiveBackground
