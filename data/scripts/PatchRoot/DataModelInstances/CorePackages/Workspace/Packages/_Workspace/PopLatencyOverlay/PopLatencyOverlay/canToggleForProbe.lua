-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:11:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function canToggleForProbe(arg1, arg2): boolean
    if not arg1 then
        return not arg2
    end

    local success, result = pcall(function()
        return arg1:IsEnabled()
    end)

    return if success then result == true else not arg2
end

return canToggleForProbe
