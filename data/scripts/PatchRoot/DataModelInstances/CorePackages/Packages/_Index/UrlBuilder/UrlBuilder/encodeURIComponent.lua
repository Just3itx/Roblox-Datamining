-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:50:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function formatCharacter(arg1): string
    return string.format("%%%02X", arg1:byte(1, 1))
end

return function(arg1)
    return arg1:gsub("[^%w_%-%!%.%~%*%'%(%)]", formatCharacter)
end
