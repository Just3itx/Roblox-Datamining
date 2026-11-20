-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:30:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local Modules = CoreGui.RobloxGui.Modules
local Constants = require(Modules.Settings.Pages.ShareGame.Constants)

local FFlagFixPromptGameInviteUIMissingDisplayName = require(CorePackages.Workspace.Packages.SharedFlags).FFlagFixPromptGameInviteUIMissingDisplayName

return function(arg1, func1: (...any) -> (...any))
    local inviteUser = if arg1 and arg1.InviteUser ~= 0 then arg1.InviteUser else nil
    local var1 = if inviteUser then Constants.Triggers.DeveloperSingle else Constants.Triggers.DeveloperMultiple
    local var2, var3 = func1(var1, inviteUser)

    if not var2 then
        return nil
    end

    local result = {}
    if FFlagFixPromptGameInviteUIMissingDisplayName and inviteUser then
        result.inviteUserId = inviteUser
    end

    if var3 and arg1 then
        if arg1.InviteMessageId ~= "" then
            result.inviteMessageId = arg1.InviteMessageId
        end
        if arg1.InviteUser ~= 0 then
            result.inviteUserId = arg1.InviteUser
        end
        if arg1.PromptMessage ~= "" then
            result.promptMessage = arg1.PromptMessage
        end
        if arg1.LaunchData ~= "" then
            result.launchData = arg1.LaunchData
        end
    end
    return result
end
