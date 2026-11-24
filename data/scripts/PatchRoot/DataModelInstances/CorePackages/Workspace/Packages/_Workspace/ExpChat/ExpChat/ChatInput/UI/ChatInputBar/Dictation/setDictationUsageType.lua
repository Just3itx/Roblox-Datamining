-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:51:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function setDictationUsageType(arg1, bool1: boolean): boolean
    return (pcall(function()
        arg1.UsageType = if bool1 then "continuous" else "dictation"
    end))
end
return setDictationUsageType
