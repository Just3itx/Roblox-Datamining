-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:11:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

local function getLocalUserId(arg1)
    local localPlayer = (arg1 or Players).LocalPlayer
    if not localPlayer then
        return nil
    end

    return tostring(localPlayer.UserId)
end

return getLocalUserId
