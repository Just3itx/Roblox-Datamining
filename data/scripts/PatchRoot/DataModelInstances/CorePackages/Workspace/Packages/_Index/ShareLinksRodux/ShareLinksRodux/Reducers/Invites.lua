-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T16:21:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Actions = scriptParentParent.Actions

local scriptParentParentParent = scriptParentParent.Parent

local Cryo = require(scriptParentParentParent.Cryo)
local Rodux = require(scriptParentParentParent.Rodux)

local SetShareInviteLink = require(Actions.SetShareInviteLink)
local ClearShareInviteLink = require(Actions.ClearShareInviteLink)

local tbl1 = {}

return function(arg1)
    local shareLinksNetworking = arg1.shareLinksNetworking

    local createReducer = Rodux.createReducer
    local tbl2 = tbl1
    local tbl3 = {}
    tbl3[shareLinksNetworking.GenerateLink.Succeeded.name] = function(arg2, arg3)
        return Cryo.Dictionary.join(arg2, { ShareInviteLink = arg3.responseBody })
    end

    tbl3[SetShareInviteLink.name] = function(arg2, arg3)
        return Cryo.Dictionary.join(arg2, { ShareInviteLink = arg3.shareInviteLink })
    end

    tbl3[ClearShareInviteLink.name] = function(arg2, _)
        return Cryo.Dictionary.join(arg2, { ShareInviteLink = Cryo.None })
    end

    return createReducer(tbl2, tbl3)
end
