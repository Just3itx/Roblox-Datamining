-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:31:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TeleportService = game:GetService("TeleportService")

local function callTeleportSwitchServer(gameIdsToExclude)
    if gameIdsToExclude ~= nil then
        TeleportService:TeleportSwitchServer(gameIdsToExclude)
        return
    end
    TeleportService:TeleportSwitchServer()
end

return callTeleportSwitchServer
