-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:40:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getLocalUserId(arg1)
    local localPlayer = arg1.LocalPlayer
    if not localPlayer then
        return nil
    end

    return tostring(localPlayer.UserId)
end

return getLocalUserId
