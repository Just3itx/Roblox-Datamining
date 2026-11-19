-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:10:40Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local colorScopeKeepPrefix = require(script.Parent.colorScopeKeepPrefix)

local function kebabToPascal(str1: string)
    return (str1:gsub("^%-?(.)", function(arg1)
        return arg1:upper()
    end):gsub("%-(.)", function(arg1)
        return arg1:upper()
    end))
end

local function tokenAttributePascalName(str1: string, str2: string)
    local var1 = kebabToPascal(str2)
    if colorScopeKeepPrefix[str1] and string.sub(var1, 1, #str1) == str1 then
        return string.sub(var1, #str1 + 1)
    end
    return var1
end

return tokenAttributePascalName
