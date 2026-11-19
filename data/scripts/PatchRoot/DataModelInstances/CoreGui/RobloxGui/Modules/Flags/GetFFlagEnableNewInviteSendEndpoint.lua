-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:41:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _Players = game:GetService("Players")

local Modules = game:GetService("CoreGui").RobloxGui.Modules
local NewInviteMenuExperimentManager = require(Modules.Settings.Pages.ShareGame.NewInviteMenuExperimentManager)

game:DefineFastFlag("EnableNewInviteSendEndpoint", false)
game:DefineFastFlag("EnableNewInviteSendEndpointIXP", false)

return function()
    return game:GetFastFlag("EnableNewInviteSendEndpoint")
        or game:GetFastFlag("EnableNewInviteSendEndpointIXP") and NewInviteMenuExperimentManager.default:getCustomizationEnabled()
end
