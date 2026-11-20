-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:30:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local ShareGame = game:GetService("CoreGui").RobloxGui.Modules.Settings.Pages.ShareGame

local Immutable = require(CorePackages.Workspace.Packages.AppCommonLib).Immutable
local ReceivedUserInviteStatus = require(ShareGame.Actions.ReceivedUserInviteStatus)

return function(arg1, arg2)
    arg1 = arg1 or {}

    if arg2.type == ReceivedUserInviteStatus.name then
        arg1 = Immutable.Set(arg1, arg2.userId, arg2.inviteStatus)
    end

    return arg1
end
