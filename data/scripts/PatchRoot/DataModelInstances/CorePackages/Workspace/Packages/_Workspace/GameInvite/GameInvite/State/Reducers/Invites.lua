-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:50:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Actions = scriptParentParent.Actions
local scriptParentParentParentParent = scriptParentParent.Parent.Parent

local Immutable = require(scriptParentParentParentParent.AppCommonLib).Immutable

local ReceivedUserInviteStatus = require(Actions.ReceivedUserInviteStatus)
local ResetUserInviteStatus = require(Actions.ResetUserInviteStatus)
return function(arg1, arg2)
    arg1 = arg1 or {}

    if arg2.type == ReceivedUserInviteStatus.name then
        return (Immutable.Set(arg1, arg2.userId, arg2.inviteStatus))
    end

    return arg2.type == ResetUserInviteStatus.name and {} or arg1
end
