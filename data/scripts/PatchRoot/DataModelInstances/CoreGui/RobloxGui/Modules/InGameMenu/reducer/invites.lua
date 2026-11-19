-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:50:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Cryo = InGameMenuDependencies.Cryo
local Rodux = InGameMenuDependencies.Rodux

local scriptParentParent = script.Parent.Parent

local ReceivedUserInviteStatus = require(scriptParentParent.Actions.ReceivedUserInviteStatus)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[ReceivedUserInviteStatus.name] = function(arg1, arg2)
    local userId = arg2.userId
    local inviteStatus = arg2.inviteStatus

    return Cryo.Dictionary.join(arg1, { [userId] = inviteStatus })
end

return createReducer({}, tbl1)
