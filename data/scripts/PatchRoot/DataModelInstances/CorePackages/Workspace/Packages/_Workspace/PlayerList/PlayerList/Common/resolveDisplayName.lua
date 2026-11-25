-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:01:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function resolveDisplayName(arg1)
    return if arg1.DisplayName == nil or arg1.DisplayName == "" then arg1.Name else arg1.DisplayName
end

return resolveDisplayName
