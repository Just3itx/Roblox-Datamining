-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:11:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local isEnabled = false

local module = {}

function module.setEnabled(bool2: boolean)
    isEnabled = bool2
end

function module.isEnabled()
    return isEnabled
end

function module.log(str1: string, str2: string?)
    if not isEnabled then
        return
    end

    if str2 then
        print(`[Composer] {str1} | {str2}`)
    else
        print(`[Composer] {str1}`)
    end
end

return module
