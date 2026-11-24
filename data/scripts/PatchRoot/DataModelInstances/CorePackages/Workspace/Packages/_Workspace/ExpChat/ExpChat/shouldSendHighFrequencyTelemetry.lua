-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:21:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocalPlayer = game:GetService("Players").LocalPlayer

return function(arg1): boolean
    return not not (LocalPlayer and LocalPlayer.UserId % 10000 < arg1)
end
