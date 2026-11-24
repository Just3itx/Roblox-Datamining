-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:51:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

local function useIsLocalUserUnder13(): boolean
    local localPlayer = Players.LocalPlayer
    return not (localPlayer == nil) and localPlayer:GetUnder13() == true
end

return useIsLocalUserUnder13
