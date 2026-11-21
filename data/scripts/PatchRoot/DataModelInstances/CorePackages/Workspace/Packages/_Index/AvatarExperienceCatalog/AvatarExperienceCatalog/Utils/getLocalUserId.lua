-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:21:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getLocalUserId(arg1)
    if not arg1.LocalPlayer then
        return nil
    end

    return tostring(arg1.LocalPlayer.UserId)
end

return getLocalUserId
