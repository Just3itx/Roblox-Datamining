-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T16:11:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local HttpService = game:GetService("HttpService")

local str1 = ""

local module = {}

function module.Get(_): string
    if str1 == "" then
        str1 = HttpService:GenerateGUID(false)
    end
    return str1
end

function module.Refresh(_)
    str1 = HttpService:GenerateGUID(false)
    return str1
end

return module
