-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:51:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameInvite = script:FindFirstAncestor("GameInvite")
local GameInviteParent = GameInvite.Parent
local getCustomizedInvitePromptUserId = require(script.Parent.getCustomizedInvitePromptUserId)
local _gameInviteModalType = require(GameInvite.gameInviteModalType)

local FFlagFixPromptGameInviteUIMissingDisplayName = require(GameInviteParent.SharedFlags).FFlagFixPromptGameInviteUIMissingDisplayName

return function(arg1, trigger, func1: (...any) -> (...any)): {trigger: any}?
    local inviteUserId = getCustomizedInvitePromptUserId(arg1)

    local var1, var2 = func1(trigger, inviteUserId)

    if not var1 then
        return nil
    end

    local tbl1 = { trigger = trigger }

    if FFlagFixPromptGameInviteUIMissingDisplayName and inviteUserId then
        tbl1.inviteUserId = inviteUserId
    end

    if var2 and arg1 then
        if arg1.InviteMessageId ~= "" then
            tbl1.inviteMessageId = arg1.InviteMessageId
        end
        if inviteUserId then
            tbl1.inviteUserId = inviteUserId
        end
        if arg1.PromptMessage ~= "" then
            tbl1.promptMessage = arg1.PromptMessage
        end
        if arg1.LaunchData ~= "" then
            tbl1.launchData = arg1.LaunchData
        end
    end
    return tbl1
end
