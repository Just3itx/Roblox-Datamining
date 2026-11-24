-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:20:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

local function getDefaultAuthHeaders()
    local localPlayer = Players.LocalPlayer
    if localPlayer == nil then
        return {}
    end

    local str1 = tostring(localPlayer.UserId)
    return { ["X-Roblox-User-Id"] = str1, ["Robloxctx-authenticated-userid"] = str1 }
end

return getDefaultAuthHeaders
