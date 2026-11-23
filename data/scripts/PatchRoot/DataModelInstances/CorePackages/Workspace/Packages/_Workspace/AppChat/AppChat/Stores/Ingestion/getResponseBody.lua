-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:21:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getResponseBody(arg1)
    return if arg1 == nil then nil else arg1.responseBody or arg1
end

return getResponseBody
