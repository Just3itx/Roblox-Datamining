-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:40:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

function module.new()
    return {}
end

function module.fromWeb(arg1)
    local var1 = arg1 or {}
    var1.placeId = tostring(var1.placeId)

    return var1
end

return module
