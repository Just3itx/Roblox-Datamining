-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:41:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

local Modules = game:GetService("CoreGui").RobloxGui.Modules
local NewInviteMenuExperimentManager = require(Modules.Settings.Pages.ShareGame.NewInviteMenuExperimentManager)

game:DefineFastInt("EnableNewInviteMenuStyleRollout", 0)
game:DefineFastFlag("EnableNewInviteMenuStyle", false)

return function()
    if not Players.LocalPlayer then
        return false
    elseif game:GetFastFlag("EnableNewInviteMenuStyle") then
        return true
    else
        local localPlayer = Players.LocalPlayer
        if game:GetFastInt("EnableNewInviteMenuStyleRollout") > localPlayer.UserId % 100 then
            return true
        end

        return NewInviteMenuExperimentManager.default:getStyleEnabled()
    end
end
