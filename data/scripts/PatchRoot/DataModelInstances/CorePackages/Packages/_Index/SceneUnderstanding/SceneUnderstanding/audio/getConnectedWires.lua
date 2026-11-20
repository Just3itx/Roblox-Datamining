-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:31:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getConnectedWires(arg1, str1: string)
    local success, result = pcall(function()
        return arg1:GetConnectedWires(str1)
    end)

    return if success then result else {}
end

return getConnectedWires
