-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:20:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

function module.Color3FromString(arg1): Color3
    local var1, var2, var3 = unpack(arg1:split("/"))
    return Color3.fromRGB(tonumber(var1), tonumber(var2), tonumber(var3))
end

return module
